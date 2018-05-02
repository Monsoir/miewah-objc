//
//  MiewahWordRequestManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"

@interface MiewahWordRequestManager : NSObject

/**
 获取 Word 列表
 
 @param pageIndex 获取页码
 @param successHandler 获取成功回调
 @param failureHandler 获取失败回调，业务上的请求失败
 @param errorHandler 获取失败回调，技术上的请求失败
 @return 该请求任务对象
 */
- (NSURLSessionDataTask *)getWordsAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
