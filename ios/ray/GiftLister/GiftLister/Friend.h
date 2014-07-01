//
//  Friend.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/15/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSSet *gifts;
@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addGiftsObject:(NSManagedObject *)value;
- (void)removeGiftsObject:(NSManagedObject *)value;
- (void)addGifts:(NSSet *)values;
- (void)removeGifts:(NSSet *)values;

+ (Friend *) newFriendwithContext: (NSManagedObjectContext *) context;

@end
