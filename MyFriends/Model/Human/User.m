#import "User.h"
#import "CoreDataStack.h"
#import "SDWebImageManager.h"

@interface User ()

@end

@implementation User

- (instancetype)init {
    NSEntityDescription *userEntityDescription = [NSEntityDescription entityForName:[User entityName]
                                                             inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];
    
    User *user = (User *)[[NSManagedObject alloc] initWithEntity:userEntityDescription
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

- (void)fetchProfilePhotoWithCompletion:(void (^)(UIImage *profilePhoto, NSError *error))completion {
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.photo]
                                                    options:0
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if (image) {
                                                          completion(image, nil);
                                                      } else {
                                                          completion(nil, error);
                                                      }
                                                  }];
}

@end
