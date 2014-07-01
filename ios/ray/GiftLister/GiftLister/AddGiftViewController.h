//
//  AddGiftViewController.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import <UIKit/UIKit.h>

@class Gift;

@protocol AddGiftViewControllerDelegate;
@interface AddGiftViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) Gift *gift;
@property (weak, nonatomic) IBOutlet UITextField *giftName;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UISwitch *giftBought;
@property (strong, nonatomic) id<AddGiftViewControllerDelegate> delegate;

-(IBAction) dismissKeyboard: (id) sender;
-(IBAction) saveOrCancel: (id) sender;

@end


@protocol AddGiftViewControllerDelegate<NSObject>

    @optional
        -(void) saveGift: (Gift *) gift;
        -(void) cancelGift: (Gift *) gift;

@end