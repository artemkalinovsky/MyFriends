//
//  PeopleTableViewController.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 28/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "PeopleTableViewController.h"
#import "RandomUserWebService.h"
#import "User.h"
#import "UserTableViewCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface PeopleTableViewController ()
@property (strong, nonatomic, nonnull) RandomUserWebService *randomUserWebService;
@property (strong, nonatomic, nonnull) NSArray<User *> *users;
@end

@implementation PeopleTableViewController

- (nonnull RandomUserWebService *)randomUserWebService {
    if (!_randomUserWebService) {
        _randomUserWebService = [[RandomUserWebService alloc] init];
    }
    return _randomUserWebService;
}

- (nonnull NSArray<User *> *)users {
    if (!_users) {
        _users = [[NSArray alloc] init];
    }
    return _users;
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 60.0f;
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControl;
    [self refresh];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.tableView.bottomRefreshControl removeTarget:self
                                               action:@selector(refresh)
                                     forControlEvents:UIControlEventValueChanged];
    [self saveSelectedUsers];
    [super viewDidDisappear:animated];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *selectedUser = self.users[indexPath.row];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!selectedUser.isFriend.boolValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedUser.isFriend = @YES;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        selectedUser.isFriend = @NO;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserTableViewCell reuseIdentifier]
                                                              forIndexPath:indexPath];

    User *user = self.users[indexPath.row];
    [cell configureWithUser:user];
    cell.accessoryType = user.isFriend.boolValue ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - IBActions

- (IBAction)refresh {
    [self saveSelectedUsers];
    __weak typeof(self) weakSelf = self;
    [self.randomUserWebService fetchRandomUsersWithCompletion:^(NSArray *users, NSError *error) {
        if (!error) {
            weakSelf.users = users;
            [weakSelf.tableView reloadData];
        } else {
        }
        [weakSelf.tableView.bottomRefreshControl endRefreshing];
        [weakSelf.tableView setContentOffset:CGPointZero animated:YES];
    }];
}

#pragma mark - Private

- (void)saveSelectedUsers {
    if (self.users.count > 0) {
        for (User *user in self.users) {
            if (user.isFriend.boolValue) {
                [user saveToFriendsList];
            }
        }
    }
}

@end