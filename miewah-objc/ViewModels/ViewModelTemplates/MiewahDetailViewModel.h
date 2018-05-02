//
//  MiewahDetailViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "MiewahWord.h"
#import "MiewahRequestProtocol.h"
#import "MiewahNetworker.h"

@interface MiewahDetailViewModel : MiewahViewModel

@property (nonatomic, copy) NSNumber *identifier;

@property (nonatomic, strong, readonly) RACSubject *loadedSuccess;
@property (nonatomic, strong, readonly) RACSubject *loadedFailure;
@property (nonatomic, strong, readonly) RACSubject *loadedError;

/**
 接口调用成功回调
 */
@property (nonatomic, copy) MiewahRequestSuccess requestSuccessHandler;

/**
 接口调用失败回调，业务上请求失败
 */
@property (nonatomic, copy) MiewahRequestFailure requestFailureHandler;

/**
 接口调用失败回调，技术上请求失败
 */
@property (nonatomic, copy) MiewahRequestError requestErrorHandler;

@property (nonatomic, strong, readonly) id<MiewahDetailRequestProtocol> requester;

- (instancetype)initWithIdentifier:(NSNumber *)identifier;
- (void)loadDetail;

@end
