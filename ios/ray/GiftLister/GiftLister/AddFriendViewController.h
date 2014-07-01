//
//  AddFriendViewController.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import <UIKit/UIKit.h>

@class Friend;

@protocol AddFriendViewControllerDelegate;

@interface AddFriendViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) id<AddFriendViewControllerDelegate> delegate;

-(IBAction) dismissKeyboard: (id) sender;
-(IBAction) cancel: (id) sender;
-(IBAction) saveFriend: (id) sender;

@end

@protocol AddFriendViewControllerDelegate <NSObject>
    @optional
        -(void) addedFriend: (Friend *) friend;
@end
