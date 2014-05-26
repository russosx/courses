//
//  AppDelegate.m
//  NSScannerTutorial
//
//  Created by Vincent Ngo on 12/14/13.
//  Copyright (c) 2013 Vincent Ngo. All rights reserved.
//

#import "AppDelegate.h"
#import "MacHardwareDataParser.h"
#import "MacHardwarePost.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSError *error = nil;
    
    //Obtain the file path to the resource folder.
    NSString *folderPath = [[NSBundle mainBundle] resourcePath]; //1
    
    //Get all the fileNames from the resource folder.
    self.listOfDataFileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]; //2
    
    //Keywords we are passing into the scanner to check if a message contains one or more of these words.
    NSArray *keywords = @[ @"apple", @"macs", @"software", @"keyboard", @"printers",
                           @"printer", @"video", @"monitor", @"laser",
                           @"scanner", @"disks", @"cost", @"price",
                           @"floppy", @"card", @"phone" ]; //3
    
    self.listOfPost = [[NSMutableArray alloc] init]; //4
    
    //Loops through the list of data files, and starts scanning and parsing them and converts them
    //to MacHardwarePost objects.
    for (NSString *fileName in self.listOfDataFileNames) //5
    {
        //ignore system files, fileName we are interested in are numbers.
        if ([fileName intValue] == 0) continue; //6
        
        NSString *path = [folderPath stringByAppendingString:
                          [NSString stringWithFormat:@"/%@", fileName]]; //7
        NSData *data = [NSData dataWithContentsOfFile: path]; //8
        
        MacHardwareDataParser *parser = [[MacHardwareDataParser alloc]
                                         initWithKeywords:keywords fileName:fileName]; //9
        
        MacHardwarePost *post = [parser parseRawDataWithData:data];//10
        
        if (post != nil)
        {
            [self.listOfPost addObject:post];//11
        }
    }
    
    //Create the masterViewController
    self.masterViewController = [[MasterViewController alloc]
                                 initWithNibName:@"MasterViewController" bundle:nil]; //12
    
    self.masterViewController.listOfMacHardwarePost = self.listOfPost;//13
    
    //Add the view controller to the Window's content view
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
