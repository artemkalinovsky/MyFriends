//
//  NSString+Validation.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 31/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isValidEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    NSString *testString = [NSString string];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *skips = [NSCharacterSet characterSetWithCharactersInString:@"1234567890-"];
    
    [scanner scanCharactersFromSet:skips intoString:&testString];
   
    return [self length] == [testString length];
}
@end
