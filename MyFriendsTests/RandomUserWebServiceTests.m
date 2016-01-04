//
//  RandomUserWebServiceTests.m
//  MyFriends
//
//  Created by Artem Kalinovsky on 04/01/2016.
//  Copyright © 2016 Artem Kalinovsky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSNocilla.h"
#import "AGAsyncTestHelper.h"
#import "AFNetworking.h"
#import "RandomUserWebServiceConstants.h"
#import "_User.h"

@interface RandomUserWebServiceTests : XCTestCase

@end

@implementation RandomUserWebServiceTests

- (void)setUp {
    [super setUp];
    [[LSNocilla sharedInstance] start];
}

- (void)tearDown {
    [[LSNocilla sharedInstance] clearStubs];
    [[LSNocilla sharedInstance] stop];
    [super tearDown];
}


- (void)testThatTheRandomUserAPIReturnsUserInfo
{
    NSDictionary *randomUserAPIResponse = @{@"results":@[
            @{
                    @"user" : @{
                    @"gender" : @"female",
                    @"name" : @{
                            @"title" : @"ms",
                            @"first" : @"manuela",
                            @"last" : @"velasco"
                    },
                    @"location" : @{
                            @"street" : @"1969 calle de alberto aguilera",
                            @"city" : @"la coruña",
                            @"state" : @"asturias",
                            @"zip" : @"56298"
                    },
                    @"email" : @"manuela.velasco50@example.com",
                    @"username" : @"heavybutterfly920",
                    @"password" : @"enterprise",
                    @"salt" : @">egEn6YsO",
                    @"md5" : @"2dd1894ea9d19bf5479992da95713a3a",
                    @"sha1" : @"ba230bc400723f470b68e9609ab7d0e6cf123b59",
                    @"sha256" : @"f4f52bf8c5ad7fc759d1d4156b25a4c7b3d1e2eec6c92d80e508aa0b7946d4ba",
                    @"registered" : @"1303647245",
                    @"dob" : @"415458547",
                    @"phone" : @"994-131-106",
                    @"cell" : @"626-695-164",
                    @"DNI" : @"52434048-I",
                    @"picture" : @{
                            @"large" : @"http://api.randomuser.me/portraits/women/39.jpg",
                            @"medium" : @"http://api.randomuser.me/portraits/med/women/39.jpg",
                            @"thumbnail" : @"http://api.randomuser.me/portraits/thumb/women/39.jpg",
                    },
                    @"version" : @"0.6",
                    @"nationality" : @"ES"

            },
                    @"seed" : @"graywolf"
            }
    ]};

    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:randomUserAPIResponse
                                                   options:0
                                                     error:&error];
    if (error) {
        XCTFail(@"HTTP fake response setup error: %@", error);
    }
    stubRequest(@"GET", @"http://api.randomuser.me/?results=20")
            .andReturn(200)
            .withHeaders(@{@"Content-Type" : @"application/json"})
            .withBody(data);


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURL *URL = [NSURL URLWithString:kRandomUserAPIURL];
    NSDictionary *params = @{ @"results" : [NSString stringWithFormat:@"%i", RandomUserAPIDefaults.resultsCount] };

    __block BOOL done = NO;
    [manager GET:URL.absoluteString
      parameters:params
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             done = YES;
             NSArray *usersJSONArray = responseObject[@"results"];
             XCTAssertGreaterThanOrEqual(usersJSONArray.count, 0, @"should have received an results");
             for (NSDictionary *userDictionary in usersJSONArray) {
                 NSString *firstName = userDictionary[@"user"][@"name"][@"first"];
                 XCTAssertEqualObjects(@"manuela", firstName, @"should have received a first name");
                 NSString *lastName = userDictionary[@"user"][@"name"][@"last"];
                 XCTAssertEqualObjects(@"velasco", lastName, @"should have received a last name");
                 NSString *email = userDictionary[@"user"][UserAttributes.email];
                 XCTAssertEqualObjects(@"manuela.velasco50@example.com", email, @"should have received an email");
                 NSString *phone = userDictionary[@"user"][UserAttributes.phone];
                 XCTAssertEqualObjects(@"994-131-106", phone, @"should have received a phone number");
                 NSString *photo = userDictionary[@"user"][@"picture"][@"large"];
                 XCTAssertEqualObjects(@"http://api.randomuser.me/portraits/women/39.jpg", photo, @"should have received a link to photo");
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
                done = YES;
                XCTFail(@"should have received a successful response: %@", error);
            }];

    AGWW_WAIT_WHILE(!done, 5);
}

@end
