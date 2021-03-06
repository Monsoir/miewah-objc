//
//  WordService.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordService.h"
#import "LeanCloudWordDAO.h"
#import "MiewahWord.h"

@interface WordService()

@property (nonatomic, strong) LeanCloudWordDAO *dao;

@end

@implementation WordService

- (NSURLSessionDataTask *)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    return [self getListFromLeanCloudAtPageIndex:pageIndex completion:completion];
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    return [self getDetailFromLeanCloudOfIdentifier:identifier completion:completion];
}

- (void)cacheList:(NSArray<MiewahAsset *> *)aList completion:(CacheCompletion)completion {
    [DatabaseHelper cacheListOfType:MiewahItemTypeWord assets:aList completion:completion];
}

- (void)readListCacheCompletion:(ReadCacheCompletion)completion {
    [DatabaseHelper readListCacheOfType:MiewahItemTypeWord completion:completion];
}

- (void)favorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion {
    [DatabaseHelper favorAnItemoOfType:MiewahItemTypeWord detail:anAsset completion:completion];
}

- (void)unfavorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion {
    [DatabaseHelper removeAnFavoriteItemOfType:MiewahItemTypeWord identifier:anAsset.objectId completion:completion];
}

- (void)isAssetFavored:(MiewahAsset *)anAsset completion:(void (^)(BOOL, NSString *))completion {
    [DatabaseHelper isFavoredItemofType:MiewahItemTypeWord identifier:anAsset.objectId completion:completion];
}

- (void)readAssetFromFavoredOf:(NSString *)identifier completion:(void(^)(MiewahAsset *asset, NSString *errorMsg))completion {
    [DatabaseHelper readItemFromFavorOfType:MiewahItemTypeWord identifier:identifier completion:completion];
}

- (void)readAssetListFromFavoredSkip:(NSInteger)skip count:(NSInteger)count completion:(void (^)(NSArray<MiewahAsset *> *, NSString *))completion {
    [DatabaseHelper readFavoredItemsOfType:MiewahItemTypeWord skip:skip size:count completion:completion];
}

- (NSURLSessionDataTask *)getListFromLeanCloudAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    return [self.dao getListAtPage:pageIndex success:^(NSArray *results) {
        NSMutableArray<MiewahWord *> *items = [NSMutableArray array];
        [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahWord *item = [[MiewahWord alloc] initWithDictionary:obj];
            [items addObject:item];
        }];
        completion(items, nil);
    } error:^(NSError *error) {
        completion(nil, error);
    }];
}

- (NSURLSessionDataTask *)getDetailFromLeanCloudOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    return [self.dao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
        MiewahWord *item = [[MiewahWord alloc] initWithDictionary:result];
        completion(item, nil);
    } error:^(NSError *error) {
        completion(nil, error);
    }];
}

- (LeanCloudWordDAO *)dao {
    if (_dao == nil) {
        _dao = [[LeanCloudWordDAO alloc] init];
    }
    return _dao;
}

@end
