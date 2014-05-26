//
//  ViewController.m
//  NSScannerTutorial
//
//  Created by Vincent Ngo on 12/15/13.
//  Copyright (c) 2013 Vincent Ngo. All rights reserved.
//

#import "MasterViewController.h"
#import "PostCellView.h"
#import "MacHardwarePost.h"

@interface MasterViewController ()

@property (strong) IBOutlet NSTextView *messageTextView;
@property (strong) IBOutlet NSTableView *tableView;

@end

@implementation MasterViewController

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    PostCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if ( [tableColumn.identifier isEqualToString:@"PostColumn"] ) //2
    {
        MacHardwarePost *post = [self.listOfMacHardwarePost objectAtIndex:row]; //3
        
        NSString *unknown = @"Unknown"; //4
        NSString *costRelated = @"NO"; //5
        
        cellView.from.stringValue = (post.fromPerson == nil) ? unknown : post.fromPerson; //6
        cellView.subject.stringValue = (post.subject == nil) ? unknown : post.subject;
        cellView.email.stringValue = (post.email == nil) ? unknown : post.email;
        cellView.costRelated.stringValue = (post.costSearch.length == 0) ? costRelated : post.costSearch;
        cellView.organization.stringValue = (post.organization == nil) ? unknown : post.organization;
        cellView.date.stringValue = (post.date == nil) ? unknown : post.date;
        cellView.lines.stringValue = [NSString stringWithFormat:@"%d", post.lines];
        cellView.keywords.stringValue = [post printKeywords]; 
    }
    
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.listOfMacHardwarePost count];
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSInteger selectedRow = [self.tableView selectedRow];  //1
    if (selectedRow >= 0 && [self.listOfMacHardwarePost count] > selectedRow)  //2
    {
        MacHardwarePost *post = [self.listOfMacHardwarePost objectAtIndex:selectedRow];  //3
        
        self.messageTextView.string = post.message;  //4
        
    }
}

@end
