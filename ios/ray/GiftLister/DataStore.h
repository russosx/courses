//
//  DataStore.h
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/15/12.
//
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

#define USER_DB @"giftlister.sqlite"

@interface DataStore : NSObject 

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(DataStore *) sharedDataStore;
-(void) resetManagedObjectContext;
-(void) saveData;

@end
