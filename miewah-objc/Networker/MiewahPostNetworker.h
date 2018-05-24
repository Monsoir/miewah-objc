//
//  MiewahPostNetworker.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/24.
//  Copyright © 2018 wenyongyang. All rights reserved.
//
//  每个 POST 请求使用一个单独的对象，尤其是要设置头部的请求
//

#import <Foundation/Foundation.h>
#import "MiewahRequestConvention.h"

@interface MiewahPostNetworker : NSObject

- (NSURLSessionDataTask *)postToURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)headers success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end
