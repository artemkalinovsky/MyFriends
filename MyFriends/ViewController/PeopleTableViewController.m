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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    __weak typeof(self) weakSelf = self;
    [self.randomUserWebService fetchRandomUsersWithCompletion:^(NSArray *users, NSError *error) {
        if (!error) {
            weakSelf.users = users;
            [weakSelf.tableView reloadData];
        } else {

        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserTableViewCell reuseIdentifier]
                                                              forIndexPath:indexPath];

    [cell configureWithUser:self.users[indexPath.row]];
    return cell;
}

@end
