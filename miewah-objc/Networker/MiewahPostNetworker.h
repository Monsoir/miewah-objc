//
//  MiewahPostNetworker.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/24.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahRequestConvention.h"

@interface MiewahPostNetworker : NSObject

- (NSURLSessionDataTask *)postToURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)headers success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end
