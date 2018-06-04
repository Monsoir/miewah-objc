//
//  NSDateFormatter+Singleton.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "NSDateFormatter+Singleton.h"

@implementation NSDateFormatter (Singleton)

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static NSDateFormatter *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[NSDateFormatter alloc] init];
        _instance.dateFormat = @"yyyyMMddHHmmssSSS";
    });
    return _instance;
}

@end
