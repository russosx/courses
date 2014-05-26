//
//  MacHardwareDataParser.h
//  NSScannerTutorial
//
//  Created by David on 25/05/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacHardwarePost.h"

@interface MacHardwareDataParser : NSObject

- (void)constructSelectorDictionary;
- (MacHardwarePost *)parseRawDataWithData:(NSData *)rawData;
- (id)initWithKeywords:(NSArray *)listOfKeywords fileName:(NSString *)fileName;

@end
