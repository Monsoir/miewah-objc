//
//  MiewahListViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "MiewahModel.h"
#import "MiewahNetworker.h"
#import "MiewahRequestProtocol.h"
#import "DatabaseHelper.h"

typedef void(^MiewahReadCacheCompletion)(void);

@interface MiewahListViewModel: MiewahViewModel

@property (nonatomic, strong, readonly) NSMutableArray *items;

@property (nonatomic, strong, readonly) RACSignal *noMoreDataSignal;

@property (nonatomic, strong, readonly) RACSubject *readCacheCompleted;
@property (nonatomic, strong, readonly) RACSubject *loadedSuccess;
@property (nonatomic, strong, readonly) RACSubject *loadedFailure;
@property (nonatomic, strong, readonly) RACSubject *loadedError;

/// 以下 3 个请求，在子类的 `initializeObserverSignals` 中进行赋值初始化
/// 在重写完 `initializeObserverSignals` 后，可调用 `resetFlags` 对所有标识进行初始化

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

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL noMoreData;
@property (nonatomic, strong, readonly) id<MiewahListRequestProtocol> requester;

/**
 读取缓存
 */
- (void)readCache;

/**
 加载数据，自动页码加一
 */
- (void)loadData;

/**
 重置所有请求标识
 
 现在包括当前页码，没有更多数据标识，清空数据数组
 */
- (void)resetFlags;

/**
 重新加载数据
 */
- (void)reloadData;

@end

@interface MiewahListViewModel(Cache)

- (BOOL)shouldCacheItems:(id)items;

@end
