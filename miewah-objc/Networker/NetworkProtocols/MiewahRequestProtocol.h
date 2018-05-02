//
//  MiewahListRequestProtocol.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahNetworker.h"

@protocol MiewahListRequestProtocol <NSObject>

/**
 获取 xxx 列表

 @param pageIndex 获取页码
 @param successHandler 获取成功回调
 @param failureHandler 获取失败回调，业务上的请求失败
 @param errorHandler 获取失败回调，技术上的请求失败
 @return 该请求任务
 */
- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end

@protocol MiewahDetailRequestProtocol <NSObject>

/**
 获取 xxx 的详情

 @param identifier xxx 的唯一标识符
 @param successHandler 获取成功回调
 @param failureHandler 获取失败回调，业务上的请求失败
 @param errorHandler 获取失败回调，技术上的请求失败
 @return 该请求任务
 */
- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSNumber *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
