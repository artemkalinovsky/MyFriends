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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithUser:(nonnull User *)user {
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    [self.userNameLabel boldSubstring:user.lastName];

    __weak typeof(self) weakSelf = self;
    [weakSelf.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:user.photo]
                                 placeholderImage:nil
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        }];
}

@end
