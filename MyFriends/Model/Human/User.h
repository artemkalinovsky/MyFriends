#import "_User.h"

@interface User : _User {}

- (instancetype)initInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
