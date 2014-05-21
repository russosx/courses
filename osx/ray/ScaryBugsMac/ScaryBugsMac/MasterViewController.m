//
//  MasterViewController.m
//  ScaryBugsMac
//
//  Created by Russ on 18/05/14.
//  Copyright (c) 2014 Russ. All rights reserved.
//

#import "MasterViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"
#import "EDStarRating.h"

@interface MasterViewController ()
@property (weak) IBOutlet NSTableView *bugsTableView;
@property (weak) IBOutlet NSTextField *bugTitleView;
@property (weak) IBOutlet NSImageView *bugImageView;
@property (weak) IBOutlet EDStarRating *bugRating;

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

#pragma mark TableView delegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Since this is a single-column table view, this would not be necessary.
    // But it's a good practice to do it in order by remember it when a table is multicolumn.
    if( [tableColumn.identifier isEqualToString:@"BugColumn"] )
    {
        ScaryBugDoc *bugDoc = [self.bugs objectAtIndex:row];
        cellView.imageView.image = bugDoc.thumbImage;
        cellView.textField.stringValue = bugDoc.data.title;
        return cellView;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.bugs count];
}

- (void)loadView
{
    [super loadView];
    self.bugRating.starImage = [NSImage imageNamed:@"star.png"];
    self.bugRating.starHighlightedImage = [NSImage imageNamed:@"shockedface2_full.png"];
    self.bugRating.starImage = [NSImage imageNamed:@"shockedface2_empty.png"];
    self.bugRating.maxRating = 5.0;
    self.bugRating.delegate = (id<EDStarRatingProtocol>)self;
    self.bugRating.horizontalMargin = 12;
    self.bugRating.editable = YES;
    self.bugRating.displayMode = EDStarRatingDisplayFull;
    
    self.bugRating.rating= 0.0;
}

#pragma mark Details

- (ScaryBugDoc*)selectedBugDoc
{
    NSInteger selectedRow = [self.bugsTableView selectedRow];
    if (selectedRow >= 0 && self.bugs.count > selectedRow)
    {
        ScaryBugDoc *selectedBug = [self.bugs objectAtIndex:selectedRow];
        return selectedBug;
    }
    return nil;
    
}

- (void)setDetailInfo:(ScaryBugDoc*)doc
{
    NSString *title = @"";
    NSImage *image = nil;
    float rating = 0.0;
    if (doc != nil)
    {
        title = doc.data.title;
        image = doc.fullImage;
        rating = doc.data.rating;
    }
    [self.bugTitleView setStringValue:title];
    [self.bugImageView setImage:image];
    [self.bugRating setRating:rating];
    
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    ScaryBugDoc *selectedDoc = [self selectedBugDoc];
    
    // Update info
    [self setDetailInfo:selectedDoc];
}

@end
