//
//  AddFriendViewController.m
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import "AddFriendViewController.h"
#import "Friend.h"
#import "DataStore.h"

@interface AddFriendViewController ()
    @property (nonatomic, strong) NSArray *months;
    @property (nonatomic, strong) NSString *selectedMonth;
    @property (nonatomic, strong) NSString *selectedDay;
    @property (nonatomic, strong) NSString *selectedYear;
@end

@implementation AddFriendViewController

#pragma mark -
#pragma mark Picker Delegate Methods

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    if (component == 0) {
        return 130.0;
    } else if (component == 1) {
        return 50.0;
    } else {
        return 70.0;
    }
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.selectedMonth = [NSString stringWithFormat:@"%d", row + 1];
    } else if (component == 1) {
        self.selectedDay = [NSString stringWithFormat:@"%d", row + 1];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *currentYear = [formatter stringFromDate:[NSDate date]];
        NSInteger calculatedYear = [currentYear integerValue] - row;
        self.selectedYear = [NSString stringWithFormat:@"%d", calculatedYear];
    }
    
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    NSInteger itemCount = 0;

    switch (component) {
        case 0:
            itemCount = 12;
            break;
        case 1:
            itemCount = 31;
            break;
        case 2:
            {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy"];
                NSString *currentYear = [formatter stringFromDate:[NSDate date]];
                itemCount = [currentYear integerValue] - 1900;
                break;
            }
    }
    
    return itemCount;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *rowTitle = nil;
    
    if (component == 0) {
        rowTitle = self.months[row];
    }
    if (component == 1) {
        rowTitle = [NSString stringWithFormat:@"%d", row+1];
    }
    if (component == 2) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *currentYear = [formatter stringFromDate:[NSDate date]];
        
        rowTitle = [NSString stringWithFormat:@"%d", [currentYear integerValue] - row];
    }
    
    return rowTitle;
}

-(BOOL) isValidDateComposedOfMonth: (NSInteger) month day: (NSInteger) day andYear: (NSInteger) year {
    
    // HMM .. TOO MUCH WORK RIGHT NOW
    // WILL ADD LATER
    // TODO: Add validation code
    return YES;
    
}

#pragma mark -
#pragma mark IBActions

-(IBAction) dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(IBAction) cancel: (id) sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction) saveFriend: (id) sender {
    
    NSManagedObjectContext *context = [[DataStore sharedDataStore] managedObjectContext];
    Friend *friend = [Friend newFriendwithContext:context];
    friend.name = self.name.text;
    
    NSInteger month = [self.selectedMonth integerValue];
    NSInteger day = [self.selectedDay integerValue];
    NSInteger year = [self.selectedYear integerValue];

    if ([self isValidDateComposedOfMonth:month day:day andYear:year]) {
    
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        [components setMonth:month];
        [components setDay:day];
        [components setYear:year];
        
        friend.birthday = [calendar dateFromComponents:components];
        if ([self.delegate respondsToSelector:@selector(addedFriend:)]) {
            [self.delegate addedFriend:friend];
        }
        [self.navigationController popViewControllerAnimated:YES];
    
    } else {
        
        // YELL AT USER
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark View Controller Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    self.selectedMonth = @"1";
    self.selectedDay = @"1";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    self.selectedYear = [formatter stringFromDate:[NSDate date]];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Add a Friend";
    self.name.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
