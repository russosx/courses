//
//  MacHardwareDataParser.m
//  NSScannerTutorial
//
//  Created by David on 25/05/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import "MacHardwareDataParser.h"

@interface MacHardwareDataParser ()

//Object that contain the fully extracted information.
@property (nonatomic, strong) MacHardwarePost *macHardwarePost; //1

//Stores selector methods that may be called by the parser.
@property (nonatomic, strong) NSDictionary *selectorDict; //2

//Contains the list of keywords to search
@property (nonatomic, strong) NSArray *listOfKeywords; //3

//Keeps track of the current file we are extracting information from
@property (nonatomic, strong) NSString *fileName; //4

@end

@implementation MacHardwareDataParser

#pragma mark - Initialization Phase

- (id)initWithKeywords:(NSArray *)listOfKeywords fileName:(NSString *)fileName {
    if ( self = [super init] )
    {
        [self constructSelectorDictionary];
        self.listOfKeywords = listOfKeywords;
        self.fileName = fileName;
    }
    return self;
}

// build scanner selectors
- (void)constructSelectorDictionary {
    self.selectorDict = @{
                          @"From" : @"extractFromWithString:",
                          @"Subject" : @"extractSubjectWithString:",
                          @"Date" : @"extractDateWithString:",
                          @"Organization" : @"extractOrganizationWithString:",
                          @"Lines" : @"extractNumberOfLinesWithString:",
                          @"Message" : @"extractMessageWithString:"
                          };
}

#pragma mark - Build Object Phase

// construct MacHardwarePost, and return object.
- (MacHardwarePost *)parseRawDataWithData:(NSData *)rawData // 1
{
    if (rawData == nil) return nil; // 2
    
    //Extracted information from raw data placed in MacHardwarePost fields.
    self.macHardwarePost = [[MacHardwarePost alloc] init]; // 3
    
    //Set the fileName within a MacHardwarePost object
    //to keep track of which file we extracted information from.
    self.macHardwarePost.fileName = self.fileName; // 4
    
    //Contains every field and message
    NSString *rawString = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding]; // 5
    
    //Split Sections, so we deal with only fields, and then messages
    NSArray *stringSections = [rawString componentsSeparatedByString:@"\n\n"]; // 6
    
    if (stringSections == nil) // 7
    {
        return nil;
    }
    
    //Don't consider data that doesn't have a message. So stringSection must be > 1
    if ([stringSections count] >= 1) // 8
    {
        //Only need to extract the fields. (Located in the 0 index)
        NSString *rawFieldString = stringSections[0]; // 9
        
        //place extracted fields into macHardwarePost properties.
        [self extractFieldsWithString:rawFieldString]; // 10
        
        //Place contiguous message blocks back together in one string.
        NSString *message = [self combineContiguousMessagesWithArray:stringSections
                                                           withRange:NSMakeRange(1, [stringSections count])]; // 11
        
        //Set macHardwarePost message field.
        [self extractMessageWithString:message]; // 12
        
        //Analyze the message for $money money, every amount searched we will record all the amounts
        // concatenate a string of $ e.g. $25, $60, $1250 in one whole string
        // Empty string if no amount of money was talked about.
        [self extractCostRelatedInformationWithMessage: message]; // 13
        
        //We are going to loop through the message string and look for the "keywords".
        [self extractKeywordsWithMessage: message]; // 14
    }
    return self.macHardwarePost; // 15
}

/*
 * extractFieldsWithString, extracts the necessary fields for a data set,
 * and places them in the mac hardware post object.
 */
- (void) extractFieldsWithString:(NSString *)rawString
{
    NSScanner *scanner = [NSScanner scannerWithString:rawString]; // 1
    
    //Delimiters
    NSCharacterSet *newLine = [NSCharacterSet newlineCharacterSet]; // 2
    
    NSString *currentLine = nil; // 3
    NSString *field = nil; // 4
    NSString *fieldInformation = nil; // 5
    
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@":"]]; // 6
    
    while (![scanner isAtEnd]) // 7
    {
        //Obtain the field
        if([scanner scanUpToString:@":" intoString:&currentLine]) { // 8
            
            //for some reason \n is always at the front. Probably because we setCharacterToBeSkipped to ":"
            field = [currentLine stringByTrimmingCharactersInSet:newLine]; // 9
        }
        
        //Obtain the value.
        if([scanner scanUpToCharactersFromSet:newLine intoString:&currentLine]) // 10
        {
            fieldInformation = currentLine; // 11
        }
        
        BOOL containsField = (self.selectorDict[field] != nil) ? YES : NO; // 12
        
        //Only parse the fields that are defined in the selectorDict.
        if (containsField)
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:NSSelectorFromString(self.selectorDict[field])
                       withObject:fieldInformation]; // 13
            #pragma clang diagnostic pop
        }
    }
}

//Extracts the subject field's value, and update post object.
- (void)extractSubjectWithString: (NSString *)rawString
{
    self.macHardwarePost.subject = rawString;
}

//Place date string into date property.
- (void)extractDateWithString: (NSString *)rawString
{
    self.macHardwarePost.date = rawString;
}

//Place the organization field value into organization property.
- (void)extractOrganizationWithString: (NSString *)rawString
{
    self.macHardwarePost.organization = rawString;
}


//Teaches you how to extract an entire message.
- (void)extractMessageWithString: (NSString *)rawString
{
    self.macHardwarePost.message = rawString;
    
}

//Teaches you how to extract a number.
- (void)extractNumberOfLinesWithString:(NSString *)rawString
{
    int numberOfLines;
    NSScanner *scanner = [[NSScanner alloc] initWithString:rawString];
    
    //scans the string for an int value.
    [scanner scanInt:&numberOfLines];
    self.macHardwarePost.lines = numberOfLines;
}

- (void)extractFromWithString: (NSString *)rawString
{
    
    //An advantage of regular expressions could be used here.
    //http://www.raywenderlich.com/30288/
    //Based on the cases stated, we need to establish some form of pattern in order to split the strings up.
    
    NSString *someRegexp = @".*[\\s]*\\({1}(.*)"; //1
    // ROGOSCHP@MAX.CC.Uregina.CA (Are we having Fun yet ???)
    // oelt0002@student.tc.umn.edu (Bret Oeltjen)
    // (iisi owner)
    // mbuntan@staff.tc.umn.edu ()
    // barry.davis@hal9k.ann-arbor.mi.us (Barry Davis)
    
    
    NSString *someRegexp2 = @".*[\\s]*<{1}(.*)"; //2
    // "Jonathan L. Hutchison" <jh6r+@andrew.cmu.edu>
    // <BR4416A@auvm.american.edu>
    // Thomas Kephart <kephart@snowhite.eeap.cwru.edu>
    // Alexander Samuel McDiarmid <am2o+@andrew.cmu.edu>
    
    // Special case:
    // Mel_Shear@maccomw.uucp
    // vng@iscs.nus.sg
    
    NSPredicate *fromPatternTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp]; //3
    NSPredicate *fromPatternTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp2];
    
    //Run through the patterns
    
    //Format: Email (Name)
    if ([fromPatternTest1 evaluateWithObject:rawString]) //4
    {
        [self extractFromParenthesesWithString:rawString];
    }
    //Format: Name <Email> || <Email>
    else if ([fromPatternTest2 evaluateWithObject: rawString]) //5
    {
        [self extractFromArrowWithString:rawString];
    }
    //Format: Email
    else
    {
        [self extractFromEmailWithString:rawString]; //6
    }
}

#pragma mark - extractFromWithString helper methods

//Extract the email, when the pattern is Format: email (No name specified)
- (void)extractFromEmailWithString:(NSString *)rawString {
    self.macHardwarePost.email = rawString;
    self.macHardwarePost.fromPerson = @"unknown";
    
}

//Extract the name of the person and email, when the pattern is Format: Name <Email>
- (void)extractFromArrowWithString:(NSString *)rawString {
    NSScanner *scanner = [NSScanner scannerWithString:rawString]; //1
    
    NSString *resultString = nil; //2
    
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]; //3
    
    while (![scanner isAtEnd]) //4
    {
        [scanner scanUpToString:@"<" intoString:&resultString]; //5
        self.macHardwarePost.fromPerson = resultString; //6
        [scanner scanUpToString:@">" intoString:&resultString]; //7
        self.macHardwarePost.email = resultString; //8
    }
}

//Extract the name of the person and email, when the pattern is Format: Email (Name)
- (void)extractFromParenthesesWithString:(NSString *)rawString
{
    NSScanner *scanner = [NSScanner scannerWithString:rawString];
    
    NSString *resultString = nil;
    
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"(" intoString:&resultString];
        self.macHardwarePost.email = resultString;
        [scanner scanUpToString:@")" intoString:&resultString];
        self.macHardwarePost.fromPerson = resultString;
    }
}

#pragma mark- Utilities

- (NSString *)combineContiguousMessagesWithArray:(NSArray *)array withRange:(NSRange)range
{
    NSMutableString *resultString = [[NSMutableString alloc] init]; //1
    
    for (int i = (int)range.location; i < range.length; i++) //2
    {
        [resultString appendString: array[i] ]; //3
    }
    
    return [NSString stringWithString:resultString]; //4
}

//Extract keywords from the message.
- (void)extractKeywordsWithMessage:(NSString *)rawString {
    NSScanner *scanner = [NSScanner scannerWithString:rawString]; //1
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet]; //2
    
    NSString *keyword = @""; //3
    
    while (![scanner isAtEnd]) //4
    {
        [scanner scanUpToCharactersFromSet:whitespace intoString:&keyword]; //5
        NSString *lowercaseKeyword = [keyword lowercaseString]; //6
        
        if([self.listOfKeywords containsObject: lowercaseKeyword]) //7
        {
            [self.macHardwarePost.setOfKeywords addObject:lowercaseKeyword]; //8
        }
    }
}

// Extract amount of cost if the message contains "$" symbol.
- (void)extractCostRelatedInformationWithMessage:(NSString *)rawString
{
    NSScanner *scanner = [NSScanner scannerWithString:rawString]; //1
    NSMutableString *costResultString = [[NSMutableString alloc] init]; //2
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet]; //3
    NSCharacterSet *dollarCharacter = [NSCharacterSet characterSetWithCharactersInString:@"$"]; //4
    
    NSString *dollarFound;
    float dollarCost;
    
    while (![scanner isAtEnd]) //5
    {
        //Have the scanner find the first $ token
        if (![scanner scanUpToCharactersFromSet:dollarCharacter intoString:nil]) //6
        {
            [scanner scanUpToCharactersFromSet:whitespace intoString:&dollarFound]; //7
            
            NSScanner *integerScanner = [NSScanner scannerWithString:dollarFound]; //8
            [integerScanner scanString: @"$" intoString:nil]; //9
            [integerScanner scanFloat: &dollarCost]; //10
            
            if (!(int)dollarCost == 0) //11
            {
                [costResultString appendFormat:@"$%.2f ", dollarCost];
            }
        }
    }
    self.macHardwarePost.costSearch = costResultString; //12
}

@end
