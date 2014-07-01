//
//  FriendSelectionViewController.m
//  GiftLister
//
//
//

#import "FriendSelectionViewController.h"
#import "GiftListViewController.h"
#import "FriendListCell.h"
#import "DataStore.h"
#import "Friend.h"


@interface FriendSelectionViewController()

@property (nonatomic, strong) NSMutableArray *friends;

@end

@implementation FriendSelectionViewController



#pragma mark -
#pragma Add Friend View Controller Delegate Methods

-(void) addedFriend: (Friend *) friend {
    [self.friends addObject:friend];
    [self.friends sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Friend *friend1 = (Friend *) obj1;
        Friend *friend2 = (Friend *) obj2;
        return [friend1.name compare:friend2.name];
    }];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == self.friends.count) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"Friendless"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Friendless"];
        }
        cell.textLabel.text = @"Add a friend";
        
        
    } else {

        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
        FriendListCell *friendCell = (FriendListCell *) cell;

        
        Friend *friend = self.friends[indexPath.row];
        
        friendCell.friendName.text = friend.name;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        
        friendCell.birthday.text = [dateFormatter stringFromDate:friend.birthday];
        friendCell.totalGifts.text = [NSString stringWithFormat:@"Total Gifts: %u", friend.gifts.count];
    }
    
    cell.userInteractionEnabled = YES;
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == self.friends.count) {
        [self performSegueWithIdentifier:@"NewUser" sender:indexPath];
    } else {
        [self performSegueWithIdentifier:@"AddGifts" sender:indexPath];
    }
}


#pragma mark -
#pragma mark View Controller Methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = (NSIndexPath *) sender;
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([[segue identifier] isEqualToString:@"NewUser"]) {
        AddFriendViewController *addFriendViewController = segue.destinationViewController;
        addFriendViewController.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"AddGifts"]) {
        Friend *friend = [self.friends objectAtIndex:indexPath.row];
        GiftListViewController *giftListViewController = (GiftListViewController *) segue.destinationViewController;
        giftListViewController.friend = friend;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];  
    NSLog(@"in viewDidLoad");
    NSLog(@"Loading friends..");

    DataStore *dataStore = [DataStore sharedDataStore];
    
    NSManagedObjectContext *context = [dataStore managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Friend" inManagedObjectContext:context]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"birthday" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    self.friends = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];


    
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor clearColor]];

    CGRect screen =[[UIScreen mainScreen] bounds];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [background setFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    
    [self.navigationController.view insertSubview:background atIndex:0];
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:3.0/255.0 green:158.0/255.0 blue:114.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

@end
