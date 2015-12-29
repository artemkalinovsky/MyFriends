#import "User.h"
#import "CoreDataStack.h"

@interface User ()

@end

@implementation User

- (instancetype)initInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSEntityDescription *userEntityDescription = [NSEntityDescription entityForName:[User entityName]
                                                       inManagedObjectContext:managedObjectContext];
    
    User *user = (User *)[[NSManagedObject alloc] initWithEntity:userEntityDescription
                                  insertIntoManagedObjectContext:nil];
    return user;
}

- (void)saveToFriendsList {
    [[CoreDataStack sharedStack].managedObjectContext insertObject:self];
    [[CoreDataStack sharedStack] saveManagedObjectContext];
}

@end
