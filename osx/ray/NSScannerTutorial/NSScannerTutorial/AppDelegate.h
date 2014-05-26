//
//  AppDelegate.h
//  NSScannerTutorial
//
//  Created by Vincent Ngo on 12/14/13.
//  Copyright (c) 2013 Vincent Ngo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MasterViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

//Stores a reference to the data set's file path. E.g. /Users/userName/Documents/comp.sys.mac.hardware
@property (nonatomic, strong) NSString *dataSetFilePath;

//Stores an array of all data file names. E.g. 50419, 50420, 50421, ...
@property (nonatomic, strong) NSArray *listOfDataFileNames;

@property (nonatomic, strong) NSMutableArray *listOfPost;

@property (nonatomic, strong) IBOutlet MasterViewController *masterViewController;

@end
