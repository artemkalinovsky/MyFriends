#import "User.h"
#import "CoreDataStack.h"

@interface User ()

@end

@implementation User

- (instancetype)init {
    NSEntityDescription *userEntityDescription = [NSEntityDescription entityForName:[User entityName]
                                                             inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];

    User *user = [[NSManagedObject alloc] initWithEntity:userEntityDescription
                          insertIntoManagedObjectContext:nil];
    return user;
}

- (void)saveToFriendsList {
    [[CoreDataStack sharedStack].managedObjectContext insertObject:self];
    [[CoreDataStack sharedStack] saveManagedObjectContext];
}

- (void)removeFromFriendsList {
    self.isFriend = @NO;
    [[CoreDataStack sharedStack] saveManagedObjectContext];
}

@end
