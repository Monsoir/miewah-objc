//
//  MiewahNetworker.h
//  miewah-objc
//
//  Created by Christopher on 2018/4/28.
//  Copyright © 2018 wenyongyang. All rights reserved.
//
//  GET 请求使用的是一个单例对象
//

#import <Foundation/Foundation.h>
#import "MiewahRequestConvention.h"

#define SharedNetworker [MiewahNetworker sharedNetworker]

@import AFNetworking;

@interface MiewahNetworker : AFHTTPSessionManager

+ (instancetype)sharedNetworker;

@end
