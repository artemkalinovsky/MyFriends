//
//  FriendDetailedInfoViewController.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 30/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import UIKit;

@class User;

@interface FriendDetailedInfoViewController : UITableViewController

@property (nonatomic, strong, nonnull) User *detailedUser;

@end
