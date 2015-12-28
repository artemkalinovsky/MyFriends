//
//  RandomUserWebService.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 29/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import Foundation;

typedef void (^RandomUserAPIResponse)(NSArray *, NSError *);

@interface RandomUserWebService : NSObject
- (void)fetchRandomUsersWithCompletion:(RandomUserAPIResponse)completion;
@end
