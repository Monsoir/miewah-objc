//
//  BaseServiceProtocol.h
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiewahAsset.h"
#import "DatabaseHelper.h"

typedef void(^ServiceGetListCompletion)(NSArray<MiewahAsset *> *list, NSError *error);
typedef void(^ServiceGetDetailCompletion)(MiewahAsset *asset, NSError *error);

@protocol BaseServiceProtocol <NSObject>

/* From server */
- (NSURLSessionDataTask *)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion;
- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion;

/* Cache */
- (void)cacheList:(NSArray<MiewahAsset *> *)aList completion:(CacheCompletion)completion;
- (void)readListCacheCompletion:(ReadCacheCompletion)completion;

/* Favor */
- (void)favorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion;
- (void)unfavorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion;
- (void)isAssetFavored:(MiewahAsset *)anAsset completion:(void(^)(BOOL favored, NSString *errorMsg))completion;
- (void)readAssetFromFavoredOf:(NSString *)identifier completion:(void(^)(MiewahAsset *asset, NSString *errorMsg))completion;


/**
 从 favor 中读取列表

 @param skip 跳过的个数
 @param count 读取的个数
 */
- (void)readAssetListFromFavoredSkip:(NSInteger)skip count:(NSInteger)count completion:(void(^)(NSArray<MiewahAsset *> *list, NSString *errorMsg))completion;

@end
