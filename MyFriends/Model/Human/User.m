#import "User.h"

@interface User ()

@end

@implementation User

- (instancetype)initInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [NSEntityDescription insertNewObjectForEntityForName:[User entityName]
                                         inManagedObjectContext:managedObjectContext];
    return self;
}

@end
