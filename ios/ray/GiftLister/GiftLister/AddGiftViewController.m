//
//  AddGiftViewController.m
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import "AddGiftViewController.h"
#import "Gift.h"

#define CANCEL 1
#define GIFT_NAME_TEXT_FIELD 1

@implementation AddGiftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.gift.name isEqualToString:@""]) {
        self.giftName.text = self.gift.name;
    }
    if ([self.gift.price intValue] > 0) {
        self.price.text = [NSString stringWithFormat:@"%.2f", [self.gift.price floatValue]];
    }
    
    if ([self.gift.isPurchased boolValue] == YES) {
        [self.giftBought setOn:YES];
    } else {
        [self.giftBought setOn:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
        
        __weak UITextField *txtField = textField;
    
        if (textField.tag == GIFT_NAME_TEXT_FIELD) {
            CGRect textFrame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y - 50, textField.frame.size.width, textField.frame.size.height);
    
            [UIView animateWithDuration:.25f animations:^{
                [txtField setFrame:textFrame];
            } completion:^(BOOL finished) {
                [txtField setFrame:textFrame];
            }];
        } else {
            
            __weak UITextField *giftNameTextField = self.giftName;
            
            CGRect giftTextFrame = CGRectMake(giftNameTextField.frame.origin.x, giftNameTextField.frame.origin.y - 95, giftNameTextField.frame.size.width, giftNameTextField.frame.size.height);
            CGRect textFrame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y - 95, textField.frame.size.width, textField.frame.size.height);
            
            [UIView animateWithDuration:.25f animations:^{
                [txtField setFrame:textFrame];
                [giftNameTextField setFrame:giftTextFrame];
            }];
            
        }
        return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {

    __weak UITextField *txtField = textField;
    
    if (textField.tag == GIFT_NAME_TEXT_FIELD) {
        CGRect textFrame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y + 50, textField.frame.size.width, textField.frame.size.height);
        
        [UIView animateWithDuration:.25f animations:^{
            [txtField setFrame:textFrame];
        } completion:^(BOOL finished) {
            [txtField setFrame:textFrame];
        }];
    } else {
        
        __weak UITextField *giftNameTextField = self.giftName;
        
        CGRect giftTextFrame = CGRectMake(giftNameTextField.frame.origin.x, giftNameTextField.frame.origin.y + 95, giftNameTextField.frame.size.width, giftNameTextField.frame.size.height);
        CGRect textFrame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y + 95, textField.frame.size.width, textField.frame.size.height);
        
        [UIView animateWithDuration:.25f animations:^{
            [txtField setFrame:textFrame];
            [giftNameTextField setFrame:giftTextFrame];
        }];
        
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction) dismissKeyboard: (id) sender {
    [self.view endEditing:YES];
}

-(IBAction) saveOrCancel:(id)sender {
    
    UIButton *button = (UIButton *) sender;
    BOOL validGift = YES;
    
    self.gift.name = self.giftName.text;
    
    if (self.gift.name == nil || [self.gift.name isEqualToString:@""]) {
        validGift = NO;
    }
    
    if (button.tag == CANCEL || validGift == NO) {
        if ([self.delegate respondsToSelector:@selector(cancelGift:)]) {
            [self.delegate cancelGift:self.gift];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(saveGift:)]) {
            
            
            if (![self.price.text isEqualToString:@""]) {
                self.gift.price = [NSNumber numberWithFloat:[self.price.text floatValue]];
            } else {
                self.gift.price = [NSNumber numberWithFloat:0];
            }
            if ([self.giftBought isOn]) {
                self.gift.isPurchased = [NSNumber numberWithBool:YES];
            } else {
                self.gift.isPurchased = [NSNumber numberWithBool:NO];
            }
            
            [self.delegate saveGift:self.gift];
        }
    }
    
}

@end
