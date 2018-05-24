//
//  MiewahUser.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/30.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserInfoKey;

#define ThisUser [MiewahUser thisUser]

@interface MiewahUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *loginToken;

+ (instancetype)aUserWithName:(NSString *)name loginToken:(NSString *)token;
+ (instancetype)thisUser;
+ (BOOL)isLogin;
- (void)clearUserInfo;
- (void)saveUserInfo;
- (void)fetchUserInfoFromLocal;

@end
