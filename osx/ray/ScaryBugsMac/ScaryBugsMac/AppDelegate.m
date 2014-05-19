//
//  AppDelegate.m
//  ScaryBugsMac
//
//  Created by Russ on 17/05/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "ScaryBugDoc.h"

@interface AppDelegate()
@property (nonatomic, strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController"
                                                                       bundle:nil];
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.bugs = [[NSMutableArray alloc] initWithArray:[self getSampleData]];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

- (NSArray*)getSampleData
{
    NSArray *bugs = @[
                      [[ScaryBugDoc alloc] initWithTitle:@"Potato Bug"
                                                  rating:4
                                              thumbImage:[NSImage imageNamed:@"potatoBugThumb.jpg"]
                                               fullImage:[NSImage imageNamed:@"potatotBug.jpg"]],
                      [[ScaryBugDoc alloc] initWithTitle:@"House Centipede"
                                                  rating:3
                                              thumbImage:[NSImage imageNamed:@"centipedeThumb.jpg"]
                                               fullImage:[NSImage imageNamed:@"centipede.jpg"]],
                      [[ScaryBugDoc alloc] initWithTitle:@"Wolf Spider"
                                                  rating:5
                                              thumbImage:[NSImage imageNamed:@"wolfSpiderThumb.jpg"]
                                               fullImage:[NSImage imageNamed:@"wolfSpider.jpg"]],
                      [[ScaryBugDoc alloc] initWithTitle:@"Lady Bug"
                                                  rating:1
                                              thumbImage:[NSImage imageNamed:@"ladybugThumb.jpg"]
                                               fullImage:[NSImage imageNamed:@"ladybug.jpg"]]
                      ];
    return bugs;
}

@end
