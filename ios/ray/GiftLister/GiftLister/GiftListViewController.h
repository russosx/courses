//
//  GiftListViewController.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import <UIKit/UIKit.h>
#import "AddGiftViewController.h"

@class Friend;
@interface GiftListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, AddGiftViewControllerDelegate>

-(IBAction) changeView:(id) sender;

@property (nonatomic, strong) Friend *friend;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *barButton;

@end
