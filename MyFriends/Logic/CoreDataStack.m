//
//  CoreDataStack.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 28/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()
@property (strong, nonatomic) NSManagedObjectContext *masterManagedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectContext *mainManagedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectContext *workerManagedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation CoreDataStack

#pragma mark - Core Data stack

@synthesize masterManagedObjectContext = _masterManagedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)sharedStack {
    static CoreDataStack *coreDataStack = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataStack = [[self alloc] init];
    });

    return coreDataStack;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyFriends" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyFriends.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)masterManagedObjectContext {
    if (_masterManagedObjectContext != nil) {
        return _masterManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _masterManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [_masterManagedObjectContext setPersistentStoreCoordinator:coordinator];
    return _masterManagedObjectContext;
}

- (NSManagedObjectContext *)mainManagedObjectContext {
    if (_mainManagedObjectContext) {
        return _mainManagedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }

    _mainManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    if (!_mainManagedObjectContext.persistentStoreCoordinator) {
//        [_mainManagedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
    _mainManagedObjectContext.parentContext = self.masterManagedObjectContext;

    return _mainManagedObjectContext;
}

- (NSManagedObjectContext *)workerManagedObjectContext {
    if (_workerManagedObjectContext) {
        return _workerManagedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }

    _workerManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//    if (!_workerManagedObjectContext.persistentStoreCoordinator) {
//        [_workerManagedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
    _workerManagedObjectContext.parentContext = self.mainManagedObjectContext;

    return _workerManagedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.masterManagedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
