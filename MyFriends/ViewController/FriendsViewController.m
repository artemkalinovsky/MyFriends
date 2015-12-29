//
//  FriendsViewController.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 29/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "FriendsViewController.h"
#import "User.h"
#import "CoreDataStack.h"
#import "UserTableViewCell.h"

@interface FriendsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong, nonnull) NSFetchedResultsController *fetchedResultsController;
@end

@implementation FriendsViewController


- (NSFetchedResultsController *)fetchedResultsController {

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:[User entityName]
                                              inManagedObjectContext:[CoreDataStack sharedStack].mainManagedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", UserAttributes.isFriend, @YES];

    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:UserAttributes.lastName
                                                         ascending:YES];

    fetchRequest.sortDescriptors = @[sort];
    fetchRequest.fetchBatchSize = 50;

    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                  managedObjectContext:[CoreDataStack sharedStack].mainManagedObjectContext
                                                                                                    sectionNameKeyPath:nil
                                                                                                             cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;

}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.fetchedResultsController performFetch:nil];
    if (self.fetchedResultsController.fetchedObjects.count > 0) {
        self.tableView.hidden = NO;
    } else {
        self.tableView.hidden = YES;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserTableViewCell reuseIdentifier]
                                                              forIndexPath:indexPath];

    User *user = self.fetchedResultsController.fetchedObjects[indexPath.row];
    [cell configureWithUser:user];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
