//
//  FriendDetailedInfoViewController.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 30/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "FriendDetailedInfoViewController.h"
#import "User.h"

@interface FriendDetailedInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@end

@implementation FriendDetailedInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.firstNameLabel.text = self.detailedUser.firstName;
    self.lastNameLabel.text = self.detailedUser.lastName;
    self.emailTextField.text = self.detailedUser.email;
    self.phoneTextField.text = self.detailedUser.phone;
    __weak typeof(self) weakSelf = self;
    [self.detailedUser fetchProfilePhotoWithCompletion:^(UIImage *profileImage, NSError *error) {
        if (profileImage) {
            weakSelf.profilePhotoImageView.image = profileImage;
        }
    }];
}

@end
