//
//  MiewahDetailViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahDetailViewModel.h"

@interface MiewahDetailViewModel ()

@property (nonatomic, strong) MiewahAsset *asset;
@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;

@property (nonatomic, strong) NSArray<NSString *> *displayContents;

@end

@implementation MiewahDetailViewModel

- (instancetype)initWithInfo:(NSDictionary *)userInfo {
    self = [super init];
    if (self) {
        self.asset = [[MiewahAsset alloc] init];
        self.asset.objectId = userInfo[AssetObjectIdKey];
        self.asset.item = userInfo[AssetItemKey];
        self.asset.pronunciation = userInfo[AssetPronunciationKey];
    }
    return self;
}

- (void)loadData {
    @weakify(self);
    [self.service getDetailOfIdentifier:self.asset.objectId completion:^(MiewahAsset *asset, NSError *error) {
        @strongify(self);
        
        if (error != nil) {
            [self.loadedFailure sendNext:error];
            return;
        }
        
        self.asset = asset;
        self.displayContents = [self makeContentToDisplay];
        [self.loadedSuccess sendNext:self.asset];
    }];
}

- (void)dealloc {
    [self.loadedSuccess sendCompleted];
    [self.loadedFailure sendCompleted];
}

- (NSArray<NSString *> *)makeContentToDisplay {
    return @[];
}

- (RACSubject *)loadedSuccess {
    if (_loadedSuccess == nil) {
        _loadedSuccess = [[RACSubject alloc] init];
    }
    return _loadedSuccess;
}

- (RACSubject *)loadedFailure {
    if (_loadedFailure == nil) {
        _loadedFailure = [[RACSubject alloc] init];
    }
    return _loadedFailure;
}

@end
