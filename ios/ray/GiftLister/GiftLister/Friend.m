//
//  Friend.m
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/15/12.
//
//

#import "Friend.h"

@implementation Friend

@dynamic name;
@dynamic birthday;
@dynamic gifts;

+ (Friend *) newFriendwithContext: (NSManagedObjectContext *) context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];
}

@end
