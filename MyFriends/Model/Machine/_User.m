// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.email = @"email",
	.firstName = @"firstName",
	.isFriend = @"isFriend",
	.lastName = @"lastName",
	.phone = @"phone",
	.photo = @"photo",
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isFriendValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFriend"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic email;

@dynamic firstName;

@dynamic isFriend;

- (BOOL)isFriendValue {
	NSNumber *result = [self isFriend];
	return [result boolValue];
}

- (void)setIsFriendValue:(BOOL)value_ {
	[self setIsFriend:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFriendValue {
	NSNumber *result = [self primitiveIsFriend];
	return [result boolValue];
}

- (void)setPrimitiveIsFriendValue:(BOOL)value_ {
	[self setPrimitiveIsFriend:[NSNumber numberWithBool:value_]];
}

@dynamic lastName;

@dynamic phone;

@dynamic photo;

@end

