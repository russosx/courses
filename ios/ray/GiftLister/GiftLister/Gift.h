//
//  Gift.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend;

@interface Gift : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * isPurchased;
@property (nonatomic, retain) NSSet *friend;
@end

@interface Gift (CoreDataGeneratedAccessors)

- (void)addFriendObject:(Friend *)value;
- (void)removeFriendObject:(Friend *)value;
- (void)addFriend:(NSSet *)values;
- (void)removeFriend:(NSSet *)values;
+ (Gift *) newGiftwithContext: (NSManagedObjectContext *) context;


@end
