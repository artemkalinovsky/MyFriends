//
//  UserTableViewCell.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 28/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import UIKit;

@class User;

@interface UserTableViewCell : UITableViewCell

+ (nonnull NSString *)reuseIdentifier;
- (void)configureWithUser:(nonnull User *)user;

@end
