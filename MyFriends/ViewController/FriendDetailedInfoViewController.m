//
//  FriendDetailedInfoViewController.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 30/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "FriendDetailedInfoViewController.h"
#import "User.h"
#import "NSString+Validation.h"

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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.phoneTextField]) {
        return self.emailTextField.becomeFirstResponder;
    } else if ([textField isEqual:self.emailTextField]) {
        return self.emailTextField.resignFirstResponder;
    }
    return YES;
}

#pragma mark - IBActions

- (IBAction)tapOnCancelBarButtonItem:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapOnDoneBarButtonItem:(UIBarButtonItem *)sender {
    if ([self.phoneTextField.text isValidPhoneNumber]) {
        self.detailedUser.phone = self.phoneTextField.text;
    } else {
        [self showAlertWithTitle:@"Error" andMessage:@"Wrong phone format"];
    }
    
    if ([self.emailTextField.text isValidEmail]) {
        self.detailedUser.email = self.emailTextField.text;
    } else {
         [self showAlertWithTitle:@"Error" andMessage:@"Wrong email format"];
    }
    
    [self.detailedUser saveChanges];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
