//
//  Gift.m
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/16/12.
//
//

#import "Gift.h"
#import "Friend.h"


@implementation Gift

@dynamic name;
@dynamic price;
@dynamic isPurchased;
@dynamic friend;

+ (Gift *) newGiftwithContext: (NSManagedObjectContext *) context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Gift" inManagedObjectContext:context];
}

@end
