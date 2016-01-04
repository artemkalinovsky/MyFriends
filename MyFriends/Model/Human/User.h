#import "_User.h"

@class UIImage;

@interface User : _User {}

- (instancetype)init;
- (instancetype)initWithJSON:(NSDictionary *)jsonSerializedUser;
+ (void)saveToFriendsMarkedUsersInArray:(NSArray<User *> *)usersArray;
- (void)saveChanges;
- (void)removeFromFriendsList;
- (void)fetchProfilePhotoWithCompletion:(void (^)(UIImage *profilePhoto, NSError *error))completion;

@end
