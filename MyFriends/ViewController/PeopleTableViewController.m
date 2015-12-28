//
//  PeopleTableViewController.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 28/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "PeopleTableViewController.h"
#import "RandomUserWebService.h"

@interface PeopleTableViewController ()
@property (strong, nonatomic) RandomUserWebService *randomUserWebService;
@end

@implementation PeopleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.randomUserWebService = [[RandomUserWebService alloc] init];
    [self.randomUserWebService fetchRandomUsersWithCompletion:^(NSArray *users, NSError *error) {
        if (!error) {
            NSLog(@"");
        } else {

        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end
