//
//  CoreDataStack.h
//  MyFriends
//
//  Created by Artem Kalinovsky on 28/12/2015.
//  Copyright © 2015 Artem Kalinovsky. All rights reserved.
//

@import CoreData;

@interface CoreDataStack : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *mainManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *workerManagedObjectContext;

+ (instancetype)sharedStack;
- (void)saveMainContext;
@end
