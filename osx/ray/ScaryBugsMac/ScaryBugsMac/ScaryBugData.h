//
//  ScaryBugData.h
//  ScaryBugsMac
//
//  Created by Russ on 18/05/14.
//  Copyright (c) 2014 Russ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject

@property (strong) NSString *title;
@property (assign) float rating;

- (id)initWithTitle:(NSString*)title rating:(float)rating;

@end
