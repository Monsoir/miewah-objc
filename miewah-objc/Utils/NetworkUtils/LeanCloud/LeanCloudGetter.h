//
//  LeanCloudGetter.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AFNetworking;

#define SharedLeanCloudGetter [LeanCloudGetter sharedGetter]
//#define ALeanCloudGetter [LeanCloudGetter aGetter]

@interface LeanCloudGetter : AFHTTPSessionManager

+ (instancetype)sharedGetter;
//+ (instancetype)aGetter;

@end
