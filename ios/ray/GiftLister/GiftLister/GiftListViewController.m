//
//  GiftListViewController.m
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import "GiftListViewController.h"
#import "DataStore.h"
#import "Friend.h"
#import "Gift.h"

#define SAVED_GIFTS 0
#define BOUGHT_GIFTS 1

@interface GiftListViewController ()

@property (nonatomic, strong) NSMutableArray *savedGifts;
@property (nonatomic, strong) NSMutableArray *boughtGifts;
@property (nonatomic, assign) int dataView;

@end

@implementation GiftListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.title = self.friend.name;
    self.boughtGifts = [[NSMutableArray alloc] init];
    self.savedGifts = [[NSMutableArray alloc] init];
    
    for (Gift *gift in self.friend.gifts) {
        if ([gift.isPurchased boolValue]) {
            [self.boughtGifts addObject:gift];
        } else {
            [self.savedGifts addObject:gift];
        }
    }
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

-(void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddOrEditGift"]) {
        
        Gift *gift = nil;
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = (NSIndexPath *) sender;
            if (self.dataView == SAVED_GIFTS) {
                gift = [self.savedGifts objectAtIndex:indexPath.row];
            } else {
                gift = [self.boughtGifts objectAtIndex:indexPath.row];
            }
        } else {
            DataStore *dataStore = [DataStore sharedDataStore];
            gift = [Gift newGiftwithContext:[dataStore managedObjectContext]];
        }
        
        AddGiftViewController *addGiftViewController = segue.destinationViewController;

        addGiftViewController.gift = gift;
        addGiftViewController.delegate = self;
    }
    
    
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rowCount = 0;
    
    if (self.dataView == SAVED_GIFTS) {
        rowCount = self.savedGifts.count;
    } else {
        rowCount = self.boughtGifts.count;
    }
    
    if (rowCount == 0) {
        
        // SET THIS TO 1 TO AT LEAST DISPLAY A MESSAGE
        
        rowCount = 1;
    }
    
    return rowCount;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"AddOrEditGift" sender:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"GiftCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Friendless"];
    }
    Gift *gift = nil;
    if (self.dataView == SAVED_GIFTS) {
        if (self.savedGifts.count) {
            gift = [self.savedGifts objectAtIndex:indexPath.row];
        }
    } else {
        if (self.boughtGifts.count) {
            gift = [self.boughtGifts objectAtIndex:indexPath.row];
        }
    }
    if (gift) {
        cell.textLabel.text = gift.name;
        [cell setUserInteractionEnabled:YES];
    } else {
        if (self.dataView == SAVED_GIFTS) {
            cell.textLabel.text = @"There are no saved gifts.";
        } else {
            cell.textLabel.text = @"There are no bought gifts.";
        }
        [cell setUserInteractionEnabled:NO];
    }
    
    
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

-(IBAction) changeView: (id) sender {
    
    self.dataView = self.segmentedControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

-(void) cancelGift:(Gift *)gift {
    DataStore *dataStore = [DataStore sharedDataStore];
    [[dataStore managedObjectContext] deleteObject:gift];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) saveGift:(Gift *)gift {
    
    if ([[gift isPurchased] boolValue]) {
        if (![self.boughtGifts containsObject:gift]) {
            [self.boughtGifts addObject:gift];
            if ([self.savedGifts containsObject:gift]) {
                [self.savedGifts removeObject:gift];
            }
        }
    } else {
        if (![self.savedGifts containsObject:gift]) {
            [self.savedGifts addObject:gift];
            if ([self.boughtGifts containsObject:gift]) {
                [self.boughtGifts removeObject:gift];
            }
        }
    }
    [self.friend addGiftsObject:gift];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
}




@end
