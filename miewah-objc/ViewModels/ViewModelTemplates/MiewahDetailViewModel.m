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
@property (nonatomic, strong) NSArray<NSString *> *displayContents;
@property (nonatomic, assign) BOOL favored;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) BOOL assetExist;

@property (nonatomic, strong) NSMutableSet *racSubjects;
@property (nonatomic, weak) RACSubject *loadedSuccess;
@property (nonatomic, weak) RACSubject *loadedFailure;
@property (nonatomic, strong) RACSubject *readFavorComplete;
@property (nonatomic, strong) RACSignal *loadingSignal;
@property (nonatomic, strong) RACSignal *favorSignal;
@property (nonatomic, strong) RACSignal *assetExistSignal;

@end

@implementation MiewahDetailViewModel

- (instancetype)initWithInfo:(NSDictionary *)userInfo {
    self = [super init];
    if (self) {
        self.asset = [[MiewahAsset alloc] init];
        self.asset.objectId = userInfo[AssetObjectIdKey];
        self.asset.item = userInfo[AssetItemKey];
        self.asset.pronunciation = userInfo[AssetPronunciationKey];
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal {
    self.favorSignal = [RACObserve(self, favored) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    self.loadingSignal = [RACObserve(self, loading) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    self.assetExistSignal = [RACObserve(self, assetExist) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
}

- (void)dealloc {
    self.loadedSuccess = nil;
    self.loadedFailure = nil;
    self.readFavorComplete = nil;
    
    NSSet *garbage = self.racSubjects;
    self.racSubjects = nil;
    
    dispatch_async(ConcurrentQueue, ^{
        [garbage makeObjectsPerformSelector:@selector(sendCompleted)];
    });
    
#if DEBUG
    NSLog(@"%@ deallocs", [self class]);
#endif
}

- (void)readFromFavor {
    @weakify(self);
    [self.service readAssetFromFavoredOf:self.asset.objectId completion:^(MiewahAsset *asset, NSString *errorMsg) {
        @strongify(self);
        if (errorMsg.length > 0) {
            return;
        }
        
        if (asset) {
            self.asset = asset;
            self.displayContents = [self makeContentToDisplay];
            self.favored = YES;
            self.assetExist = YES;
        }
        [self.readFavorComplete sendCompleted];
    }];
}

- (void)loadData {
    self.loading = YES;
    @weakify(self);
    [self.service getDetailOfIdentifier:self.asset.objectId completion:^(MiewahAsset *asset, NSError *error) {
        @strongify(self);
        self.loading = NO;
        
        if (error != nil) {
            [self.loadedFailure sendNext:error];
            return;
        }
        
        self.asset = asset;
        self.displayContents = [self makeContentToDisplay];
        if (self.assetExist == NO) self.assetExist = YES;
        [self.loadedSuccess sendNext:self.asset];
    }];
}

- (void)favorAsset {
    @weakify(self);
    [self.service favorAnAsset:self.asset completion:^(BOOL success, NSString *errorMsg) {
        @strongify(self);
        // success 指的是数据库操作的成功状态
        // favored 指的是是否已经 favor
        if (success) self.favored = YES;
    }];
}

- (void)unfavorAsset {
    @weakify(self);
    [self.service unfavorAnAsset:self.asset completion:^(BOOL success, NSString *errorMsg) {
        @strongify(self);
        // success 指的是数据库操作的成功状态
        // favored 指的是是否已经 favor
        if (success) self.favored = NO;
    }];
}

#pragma mark - Accessors

- (NSArray<NSString *> *)makeContentToDisplay {
    return @[];
}

- (RACSubject *)loadedSuccess {
    if (_loadedSuccess == nil) {
        RACSubject *t = [[RACSubject alloc] init];
        [self.racSubjects addObject:t];
        _loadedSuccess = t;
    }
    return _loadedSuccess;
}

- (RACSubject *)loadedFailure {
    if (_loadedFailure == nil) {
        RACSubject *t = [[RACSubject alloc] init];
        [self.racSubjects addObject:t];
        _loadedFailure = t;
    }
    return _loadedFailure;
}

- (RACSubject *)readFavorComplete {
    if (_readFavorComplete == nil) {
        _readFavorComplete = [[RACSubject alloc] init];
    }
    return _readFavorComplete;
}

- (NSMutableSet *)racSubjects {
    if (_racSubjects == nil) {
        _racSubjects = [NSMutableSet set];
    }
    return _racSubjects;
}

@end
