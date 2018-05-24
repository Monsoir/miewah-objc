//
//  MiewahAssetRequestManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/23.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahAssetRequestManager.h"
#import "MiewahCharacterRequestManager.h"
#import "MiewahWordRequestManager.h"
#import "MiewahSlangRequesterManager.h"

@interface MiewahAssetRequestManager()

@property (nonatomic, strong) MiewahPostNetworker *requester;

@end

@implementation MiewahAssetRequestManager

+ (instancetype)requestManagerOfType:(MiewahItemType)type {
    switch (type) {
        case MiewahItemTypeCharacter:
            return [[MiewahCharacterRequestManager alloc] init];
        case MiewahItemTypeWord:
            return [[MiewahWordRequestManager alloc] init];
        case MiewahItemTypeSlang:
            return [[MiewahSlangRequesterManager alloc] init];
            
        default:
            return nil;
    }
}

- (NSURLSessionDataTask *)getListAtPage:(NSInteger)pageIndex success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    return nil;
}

- (NSURLSessionDataTask *)getDetailOfIdentifier:(NSNumber *)identifier success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    return nil;
}

- (NSURLSessionDataTask *)postNewAsset:(NSDictionary *)asset success:(MiewahRequestSuccess)successHandler failure:(MiewahRequestFailure)failureHandler error:(MiewahRequestError)errorHandler {
    return nil;
}

- (MiewahPostNetworker *)requester {
    if (_requester == nil) {
        _requester = [[MiewahPostNetworker alloc] init];
    }
    return _requester;
}

@end
