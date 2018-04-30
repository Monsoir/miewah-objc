//
//  MiewahNetworker.m
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahNetworker.h"

static NSString * const MiewahAPIBaseURLString = @"";

@implementation MiewahNetworker

+ (instancetype)sharedNetworker {
    static MiewahNetworker *_miewahNetworker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _miewahNetworker = [[MiewahNetworker alloc] initWithBaseURL:[NSURL URLWithString:MiewahAPIBaseURLString]];
//        _miewahNetworker.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _miewahNetworker;
}

@end
