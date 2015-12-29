//
//  FriendsViewController.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 29/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import UIKit;
@import CoreData;

@interface FriendsViewController : UIViewController <UITableViewDelegate,
                                                     UITableViewDataSource,
                                                     NSFetchedResultsControllerDelegate>

@end
