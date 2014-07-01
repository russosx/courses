//
//  FriendListCell.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/15/12.
//
//

#import <UIKit/UIKit.h>

@interface FriendListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *totalGifts;

@end
