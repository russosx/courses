//
//  ScaryBugDoc.h
//  ScaryBugsMac
//
//  Created by Russ on 18/05/14.
//  Copyright (c) 2014 Russ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaryBugData;

@interface ScaryBugDoc : NSObject

@property (strong) ScaryBugData *data;
@property (strong) NSImage *thumbImage;
@property (strong) NSImage *fullImage;

- (id)initWithTitle:(NSString*)title
             rating:(float)rating
         thumbImage:(NSImage*)thumbImage
          fullImage:(NSImage*) fullImage;

@end
