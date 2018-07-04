//
//  LeanCloudAPIManager.m
//  miewah-objc
//
//  Created by Christopher on 2018/7/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "LeanCloudAPIManager.h"
#import "LeanCloudAPIAddresses.h"

@implementation LeanCloudAPIManager

+ (instancetype)sharedManager {
    static LeanCloudAPIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[LeanCloudAPIManager alloc] init];
    });
    return _sharedManager;
}

- (NSString *)listParams:(NSInteger)pageIndex {
    static NSInteger PageSize = 10;
    static NSString *ListParamsFormat = @"limit=%ld&&order=-updatedAt&&keys=item,pronunciation,meaning&&skip=%ld";
    return [NSString stringWithFormat:ListParamsFormat, (long)PageSize, (long)pageIndex];
}

#pragma mark - Character

- (NSString *)characterListURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@?%@", LeanCloudBaseURL, LeanCloudCharacterListURL, [self listParams:pageIndex]];
}

- (NSString *)characterDetailOfIdentifier:(NSString *)identifier {
    return [NSString stringWithFormat:@"%@%@/%@", LeanCloudBaseURL, LeanCloudCharacterDetailURL, identifier];
}

#pragma mark - Word

- (NSString *)wordListURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@?%@", LeanCloudBaseURL, LeanCloudWordListURL, [self listParams:pageIndex]];
}

- (NSString *)wordDetailOfIdentifier:(NSString *)identifier {
    return [NSString stringWithFormat:@"%@%@/%@", LeanCloudBaseURL, LeanCloudWordDetailURL, identifier];
}

#pragma mark - Slang

- (NSString *)slangListURLWithPageIndex:(NSInteger)pageIndex {
    return [NSString stringWithFormat:@"%@%@?%@", LeanCloudBaseURL, LeanCloudSlangListURL, [self listParams:pageIndex]];
}

- (NSString *)slangDetailOfIdentifier:(NSString *)identifier {
    return [NSString stringWithFormat:@"%@%@/%@", LeanCloudBaseURL, LeanCloudSlangDetailURL, identifier];
}

@end
