//
//  NSString+Validation.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 31/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import Foundation;

@interface NSString (Validation)

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;

@end
