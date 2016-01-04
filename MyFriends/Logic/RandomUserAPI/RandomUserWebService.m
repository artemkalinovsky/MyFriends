//
//  RandomUserWebService.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 29/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

#import "RandomUserWebService.h"
#import "RandomUserWebServiceConstants.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "User.h"

@interface RandomUserWebService ()

@end

@implementation RandomUserWebService

- (void)fetchRandomUsersWithCompletion:(RandomUserAPIResponse)completion {

    NSURL *URL = [NSURL URLWithString:kRandomUserAPIURL];
    NSDictionary *params = @{ @"results" : [NSString stringWithFormat:@"%i", RandomUserAPIDefaults.resultsCount] };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [manager GET:URL.absoluteString
      parameters:params
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             NSArray *usersJSONArray = responseObject[@"results"];
             NSArray *users = [weakSelf parseUsersJSONArray:usersJSONArray];
             dispatch_async(dispatch_get_main_queue(), ^{
                 completion(users, nil);
                 [SVProgressHUD dismiss];
             });
             [SVProgressHUD dismiss];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                    [SVProgressHUD dismiss];
                });
            }];
}

- (NSArray *)parseUsersJSONArray:(NSArray *)users {
    NSMutableArray *fetchedUsers = [[NSMutableArray alloc] init];

    for (NSDictionary *userDictionary in users) {
        @try {
            User *user = [[User alloc] initWithJSON:userDictionary];
            [fetchedUsers addObject:user];
        } @catch (NSException *e) {
            
        }
    }
    return fetchedUsers;
}

@end
