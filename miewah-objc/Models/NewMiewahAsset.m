//
//  NewMiewahInstance.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "NewMiewahAsset.h"

@interface NewMiewahAsset()

@property (nonatomic, strong) MiewahAsset *currentAsset;

@end

@implementation NewMiewahAsset

- (void)setType:(MiewahItemType)type {
    _type = type;
    _currentAsset = [MiewahAsset assetOfType:_type];
}

static NewMiewahAsset *_asset = nil;
+ (NewMiewahAsset *)sharedAsset {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _asset = [[NewMiewahAsset alloc] init];
        _asset.type = MiewahItemTypeNone;
    });
    return _asset;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _asset = [super allocWithZone:zone];
        _asset.type = MiewahItemTypeNone;
    });
    return _asset;
}

@end
