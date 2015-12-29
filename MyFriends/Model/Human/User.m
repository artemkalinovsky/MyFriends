#import "User.h"
#import "CoreDataStack.h"
#import "SVProgressHUD.h"

@interface User ()

@end

@implementation User

- (instancetype)initInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [NSEntityDescription insertNewObjectForEntityForName:[User entityName]
                                         inManagedObjectContext:managedObjectContext];
    return self;
}

- (void)saveToFriendsList {
    User *savingUser = [[User alloc] initInManagedObjectContext:[CoreDataStack sharedStack].mainManagedObjectContext];
    savingUser.firstName = self.firstName;
    savingUser.lastName = self.lastName;
    savingUser.email = self.email;
    savingUser.phone = self.phone;
    savingUser.photo = self.photo;
    self.isFriend = savingUser.isFriend = @YES;
    [[CoreDataStack sharedStack] saveMainContext];
}

@end
