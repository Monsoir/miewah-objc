//
//  MiewahCharacterRequestManager.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahNetworker.h"

@interface MiewahCharacterRequestManager : NSObject


/**
 获取 Character 列表

 @param pageIndex 获取页码
 @param successHandler 获取成功回调
 @param failureHandler 获取失败回调，业务上的请求失败
 @param errorHandler 获取失败回调，技术上的请求失败
 @return 该请求任务对象
 */
- (NSURLSessionDataTask *)getCharactersAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

/**
 获取 Character 详情

 @param identifier 该 Character 的唯一标识符
 @param successHandler 获取成功回调
 @param failureHandler 获取失败回调，业务上的请求失败
 @param errorHandler 获取失败回调，技术上的请求失败
 @return 该请求任务对象
 */
- (NSURLSessionDataTask *)getCharacterDetail:(NSString *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler;

@end
