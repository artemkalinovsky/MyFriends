#import "User.h"
#import "CoreDataStack.h"
#import "SDWebImageManager.h"

@interface User ()

@end

@implementation User

- (instancetype)init {
    NSEntityDescription *userEntityDescription = [NSEntityDescription entityForName:[User entityName]
                                                             inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];

    self = (User *)[[NSManagedObject alloc] initWithEntity:userEntityDescription
                            insertIntoManagedObjectContext:nil];
    return self;
}

- (instancetype)initWithJSON:(NSDictionary *)jsonSerializedUser {
    if (self = [self init]) {
        self.firstName = jsonSerializedUser[@"user"][@"name"][@"first"];
        self.lastName = jsonSerializedUser[@"user"][@"name"][@"last"];
        self.email = jsonSerializedUser[@"user"][UserAttributes.email];
        self.phone = jsonSerializedUser[@"user"][UserAttributes.phone];
        self.photo = jsonSerializedUser[@"user"][@"picture"][@"large"];
    }
    return self;
}

+ (void)saveToFriendsMarkedUsersInArray:(NSArray<User *> *)usersArray {
    if (usersArray.count > 0) {
        for (User *user in usersArray) {
            if (user.isFriend.boolValue) {
                [[CoreDataStack sharedStack].managedObjectContext insertObject:user];
            }
        }
        [[CoreDataStack sharedStack] saveManagedObjectContext];
    }
}

- (void)saveChanges {
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
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              completion(image, nil);
                                                          });
                                                      } else {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              completion(nil, error);
                                                          });
                                                      }
                                                  }];
}

@end
