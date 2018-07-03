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

- (void)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    [self getListFromLeanCloudAtPageIndex:pageIndex completion:completion];
}

- (void)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    [self getDetailFromLeanCloudOfIdentifier:identifier completion:completion];
}

- (void)getListFromLeanCloudAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    [self.dao getListAtPage:pageIndex success:^(NSArray *results) {
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

- (void)getDetailFromLeanCloudOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    [self.dao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
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
