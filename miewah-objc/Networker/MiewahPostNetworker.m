//
//  MiewahPostNetworker.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/24.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahPostNetworker.h"

@import AFNetworking;

@implementation MiewahPostNetworker

- (NSURLSessionDataTask *)postToURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)headers success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    for (NSString *key in headers) {
        [manager.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    
    return [manager POST:url
              parameters:params
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     success(task, responseObject);
                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     failure(task, error);
                     
                 }];
}

@end
