#import "_User.h"

@class UIImage;

@interface User : _User {}

- (instancetype)init;
- (void)saveToFriendsList;
- (void)removeFromFriendsList;
- (void)fetchProfilePhotoWithCompletion:(void (^)(UIImage *profilePhoto, NSError *error))completion;

@end
