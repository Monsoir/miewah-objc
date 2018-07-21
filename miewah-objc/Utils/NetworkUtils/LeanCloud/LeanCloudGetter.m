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

- (void)dealloc {
    NSLog(@"%@ deallocs", [self class]);
}

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

+ (instancetype)aGetter {
    LeanCloudGetter *getter = [[LeanCloudGetter alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    [getter.requestSerializer setValue:LeanCloudApplicationKey forHTTPHeaderField:@"X-Avoscloud-Application-Key"];
    [getter.requestSerializer setValue:LeanCloudApplicationId forHTTPHeaderField:@"X-Avoscloud-Application-Id"];
    return getter;
}

@end
