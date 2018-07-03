//
//  LeanCloudGetter.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LeanCloudGetter.h"
#import "LeanCloudAPIAddresses.h"

@implementation LeanCloudGetter

+ (instancetype)sharedGetter {
    static LeanCloudGetter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LeanCloudGetter alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        [_instance.requestSerializer setValue:LeanCloudApplicationKey forHTTPHeaderField:@"X-Avoscloud-Application-Key"];
        [_instance.requestSerializer setValue:LeanCloudApplicationId forHTTPHeaderField:@"X-Avoscloud-Application-Id"];
    });
    return _instance;
}

@end
