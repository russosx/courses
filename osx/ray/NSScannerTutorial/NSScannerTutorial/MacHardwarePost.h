//
//  MacHardwarePost.h
//  NSScannerTutorial
//
//  Created by David on 25/05/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MacHardwarePost : NSObject

//The field’s values once extracted placed in the properties.
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *fromPerson;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *organization;
@property (nonatomic, strong) NSString *message;
@property int lines;

//Does this post have any money related information? E.g. $25, $50, $2000 etc.
@property (nonatomic, strong) NSString *costSearch;

//Contains a set of distinct keywords.
@property (nonatomic, strong) NSMutableSet *setOfKeywords;

- (NSString *) printKeywords;

@end
