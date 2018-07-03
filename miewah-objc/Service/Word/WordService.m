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

- (void)getListAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    [self getListFromLeanCloudAtPageIndex:pageIndex completion:completion];
}

- (void)getDetailOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    [self getDetailFromLeanCloudOfIdentifier:identifier completion:completion];
}

- (void)getListFromLeanCloudAtPageIndex:(NSInteger)pageIndex completion:(ServiceGetListCompletion)completion {
    [self.dao getListAtPage:pageIndex success:^(NSArray *results) {
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

- (void)getDetailFromLeanCloudOfIdentifier:(NSString *)identifier completion:(ServiceGetDetailCompletion)completion {
    [self.dao getDetailOfIdentifier:identifier success:^(NSDictionary *result) {
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
