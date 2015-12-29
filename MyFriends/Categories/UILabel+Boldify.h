//
//  UILabel+Boldify.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 29/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import UIKit;

@interface UILabel (Boldify)

- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;

@end
