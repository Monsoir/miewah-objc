//
//  MiewahUser.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahUser.h"
#import "FoundationConstants.h"

NSString * const UserInfoKey = @"userInfo";

@implementation MiewahUser

+ (instancetype)aUserWithName:(NSString *)name loginToken:(NSString *)token {
    MiewahUser *aUser = [[MiewahUser alloc] init];
    aUser.name = name;
    aUser.loginToken = token;
    return aUser;
}


static MiewahUser *_user = nil;
+ (instancetype)thisUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[MiewahUser alloc] init];
    });
    return _user;
}

- (void)saveUserInfo {
    NSDictionary *serializedInfo = [self toDictionary];
    [StandardUserDefault setObject:serializedInfo forKey:UserInfoKey];
    [StandardUserDefault synchronize];
}

- (void)fetchUserInfo {
    NSDictionary *serializedInfo = [StandardUserDefault objectForKey:UserInfoKey];
    
    NSArray *keys = [[self class] serializedPropertyKeys];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setValue:[serializedInfo objectForKey:obj] forKey:obj];
    }];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
#if DEBUG
    NSLog(@"Oh, MiewahUser has detected a undefined key from user default");
#endif
}

- (void)clearUserInfo {
    [StandardUserDefault setObject:nil forKey:UserInfoKey];
    [StandardUserDefault synchronize];
    [self fetchUserInfo];
}

/**
 将对象序列化为字典

 @return 对象序列化后的字典
 */
- (NSDictionary *)toDictionary {
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    NSArray *keys = [[self class] serializedPropertyKeys];
    
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        d[obj] = [self valueForKey:obj];
    }];
    return [d copy];
}

+ (NSArray <NSString *> *)serializedPropertyKeys {
    return @[NSStringFromSelector(@selector(name)),
             NSStringFromSelector(@selector(loginToken))];
}

@end
