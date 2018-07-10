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

- (void)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion;
- (void)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion;

- (void)cacheList:(NSArray<MiewahAsset *> *)aList completion:(CacheCompletion)completion;
- (void)readListCacheCompletion:(ReadCacheCompletion)completion;

- (void)favorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion;
- (void)unfavorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion;
- (void)isAssetFavored:(MiewahAsset *)anAsset completion:(void(^)(BOOL favored, NSString *errorMsg))completion;
- (void)readAssetFromFavoredOf:(NSString *)identifier completion:(void(^)(MiewahAsset *asset, NSString *errorMsg))completion;
//- (void)readFromFavorForAnItem:(NSString *)itemId ofType:(MiewahItemType)type completion:(ServiceGetDetailCompletion)completion;
//- (void)readFromFavorForItemListOfType:(MiewahItemType)type;

@end
