//
//  MacHardwarePost.m
//  NSScannerTutorial
//
//  Created by David on 25/05/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import "MacHardwarePost.h"

@implementation MacHardwarePost

- (id)init
{
    if (self = [super init]) {
        _setOfKeywords = [[NSMutableSet alloc] init];
    }
    return self;
}

- (NSString *)printKeywords
{
    NSMutableString *result = [[NSMutableString alloc] init];

    NSUInteger i = 0; //2
    NSUInteger numberOfKeywords = [self.setOfKeywords count];

    if (numberOfKeywords == 0)
        return @"No keywords found.";
    
    for (NSString *keyword in self.setOfKeywords)
    {
        [result appendFormat:(i != numberOfKeywords - 1) ? @" %@," : @" %@", keyword];
        i++;
    }
    
    return result;
}

@end
