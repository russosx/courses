//
//  ScaryBugDoc.m
//  ScaryBugsMac
//
//  Created by Russ on 18/05/14.
//  Copyright (c) 2014 Russ. All rights reserved.
//

#import "ScaryBugDoc.h"
#import "ScaryBugData.h"

@implementation ScaryBugDoc

- (id)initWithTitle:(NSString *)title
             rating:(float)rating
         thumbImage:(NSImage *)thumbImage
          fullImage:(NSImage *)fullImage
{
    if (self = [super init]) {
        self.data = [[ScaryBugData alloc] initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
