//
//  MiewahListViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "BaseServiceProtocol.h"
#import "MiewahAsset.h"
#import "MiewahRequestProtocol.h"
#import "DatabaseHelper.h"

typedef void(^MiewahReadCacheCompletion)(void);

@interface MiewahListViewModel: NSObject

@property (nonatomic, strong, readonly) NSMutableArray<MiewahAsset *> *items;

@property (nonatomic, strong, readonly) id<BaseServiceProtocol> service;
@property (nonatomic, strong, readonly) RACSubject *readCacheCompleted;
@property (nonatomic, strong, readonly) RACSubject *readFavoredCompleted;
@property (nonatomic, strong, readonly) RACSubject *loadedSuccess;
@property (nonatomic, strong, readonly) RACSubject *loadedFailure;

@property (nonatomic, assign, readonly) NSInteger skip;

+ (instancetype)viewModelOfType:(MiewahItemType)type;

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
 重新加载数据，从 server 读取
 */
- (void)reloadData;


/**
 读取 favored
 
 内部维护一个读取状态，继续读取直接调用此方法
 */
- (void)readFavored;

+ (MiewahItemType)assetType;

@end
