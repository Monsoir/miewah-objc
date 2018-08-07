//
//  SlangService.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangService.h"
#import "LeanCloudSlangDAO.h"
#import "MiewahSlang.h"

@interface SlangService()

@property (nonatomic, strong) LeanCloudSlangDAO *dao;

@end

@implementation SlangService

- (NSURLSessionDataTask *)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    return [self getListFromLeanCloudAtPageIndex:pageIndex completion:completion];
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    return [self getDetailFromLeanCloudOfIdentifier:identifier completion:completion];
}

- (void)cacheList:(NSArray<MiewahAsset *> *)aList completion:(CacheCompletion)completion {
    [DatabaseHelper cacheListOfType:MiewahItemTypeSlang assets:aList completion:completion];
}

- (void)readListCacheCompletion:(ReadCacheCompletion)completion {
    [DatabaseHelper readListCacheOfType:MiewahItemTypeSlang completion:completion];
}

- (void)favorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion {
    [DatabaseHelper favorAnItemoOfType:MiewahItemTypeSlang detail:anAsset completion:completion];
}

- (void)unfavorAnAsset:(MiewahAsset *)anAsset completion:(CacheCompletion)completion {
    [DatabaseHelper removeAnFavoriteItemOfType:MiewahItemTypeSlang identifier:anAsset.objectId completion:completion];
}

- (void)isAssetFavored:(MiewahAsset *)anAsset completion:(void (^)(BOOL, NSString *))completion {
    [DatabaseHelper isFavoredItemofType:MiewahItemTypeSlang identifier:anAsset.objectId completion:completion];
}

- (void)readAssetFromFavoredOf:(NSString *)identifier completion:(void(^)(MiewahAsset *asset, NSString *errorMsg))completion {
    [DatabaseHelper readItemFromFavorOfType:MiewahItemTypeSlang identifier:identifier completion:completion];
}

- (void)readAssetListFromFavoredSkip:(NSInteger)skip count:(NSInteger)count completion:(void (^)(NSArray<MiewahAsset *> *, NSString *))completion {
    [DatabaseHelper readFavoredItemsOfType:MiewahItemTypeSlang skip:skip size:count completion:completion];
}

- (NSURLSessionDataTask *)getListFromLeanCloudAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    return [self.dao getListAtPage:pageIndex success:^(NSArray *results) {
        NSMutableArray<MiewahSlang *> *items = [NSMutableArray array];
        [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahSlang *item = [[MiewahSlang alloc] initWithDictionary:obj];
            [items addObject:item];
        }];
        completion(items, nil);
    } error:^(NSError *error) {
        completion(nil, error);
    }];
}

- (NSURLSessionDataTask *)getDetailFromLeanCloudOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    return [self.dao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
        MiewahSlang *item = [[MiewahSlang alloc] initWithDictionary:result];
        completion(item, nil);
    } error:^(NSError *error) {
        completion(nil, error);
    }];
}

- (LeanCloudSlangDAO *)dao {
    if (_dao == nil) {
        _dao = [[LeanCloudSlangDAO alloc] init];
    }
    return _dao;
}

@end
