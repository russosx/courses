//
//  DataStore.m
//  GiftLister
//
//  Created by Brian Douglas Moakley on 12/15/12.
//
//

#import "DataStore.h"

@interface DataStore()

@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataStore

+(DataStore *) sharedDataStore {
    
    static DataStore *sharedInstance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[DataStore alloc] init];
    });
    return nil;
}

-(void) resetManagedObjectContext {
    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
}

-(NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext == nil) {
        NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        NSString *directory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *storeURL = [NSURL fileURLWithPath:[directory stringByAppendingPathComponent:USER_DB]];
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            
        }
    }
    return _persistentStoreCoordinator;
}

-(NSManagedObjectModel *) managedObjectModel {
    if (_managedObjectModel == nil) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _managedObjectModel;
}

-(void) saveData {
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // ACK! DO SOMETHING;
    }
}






@end

