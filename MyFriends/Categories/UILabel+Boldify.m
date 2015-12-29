//
//  UILabel+Boldify.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 29/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "UILabel+Boldify.h"

@implementation UILabel (Boldify)

- (void)boldRange:(NSRange)range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]} range:range];
    self.attributedText = attributedText;
}

- (void)boldSubstring:(NSString*)substring {
    if(!substring) return;
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}

@end
