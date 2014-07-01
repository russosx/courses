//
//  FriendSelectionViewController.h
//  GiftLister
//
//
//

#import <UIKit/UIKit.h>
#import "AddFriendViewController.h"

@interface FriendSelectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddFriendViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end
