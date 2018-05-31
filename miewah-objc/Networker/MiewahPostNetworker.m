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
                     // AFURLSessionManager 的属性 `session` 对 AFURLSessionManager 本身有强引用，导致饮用循环
                     // 调用下面的方法，将 `session` 置 nil
                     // 单独使用 AFURLSessionManager 时需要调用，创建单例的话没所谓
                     [manager invalidateSessionCancelingTasks:YES];
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     failure(task, error);
                     [manager invalidateSessionCancelingTasks:YES];
                 }];
}

@end
