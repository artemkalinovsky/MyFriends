//
//  UserTableViewCell.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 28/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "UserTableViewCell.h"
#import "_User.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "UILabel+Boldify.h"

@interface UserTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation UserTableViewCell

+ (nonnull NSString *)reuseIdentifier {
    return @"userTableViewCellReuseIdentifier";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.frame.size.width / 2;
    self.userPhotoImageView.clipsToBounds = YES;
}

- (void)configureWithUser:(nonnull User *)user {
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    [self.userNameLabel boldSubstring:user.lastName];

    __weak typeof(self) weakSelf = self;
    self.userPhotoImageView.image = [UIImage imageNamed:@"user_photo_placeholder"];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:user.photo]
                                                    options:0
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if (image) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              weakSelf.userPhotoImageView.image = image;
                                                          });
                                                      }
                                                  }];
}

@end
