//
//  ScaryBugData.m
//  ScaryBugsMac
//
//  Created by Russ on 18/05/14.
//  Copyright (c) 2014 Russ. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

- (id)initWithTitle:(NSString *)title rating:(float)rating
{
    if (self = [super init]) {
        self.title = title;
        self.rating = rating;
    }
    return self;
}

@end
