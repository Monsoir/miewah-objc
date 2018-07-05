//
//  MiewahListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahListViewModel.h"
#import "FoundationConstants.h"

@interface MiewahListViewModel ()

@property (nonatomic, strong) NSMutableArray<MiewahAsset *> *items;

@property (nonatomic, strong) RACSubject *readCacheCompleted;
@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;
@property (nonatomic, assign) NSInteger skip;

@end

@implementation MiewahListViewModel

- (void)dealloc {
    [self.loadedSuccess sendCompleted];
    [self.loadedFailure sendCompleted];
}

+ (MiewahItemType)assetType {
    return MiewahItemTypeNone;
}

- (void)readCache {
    [self.items removeAllObjects];
    
    @weakify(self);
    [self.service readListCacheCompletion:^(BOOL success, NSArray<MiewahAsset *> *assets, NSString *errorMsg) {
        @strongify(self);
        if (success) {
            [self.items addObjectsFromArray:assets];
            [self.readCacheCompleted sendCompleted];
        }
#warning 错误处理
    }];
}

- (void)loadData {
    @weakify(self);
    [self.service getListAtPageIndex:self.skip completion:^(NSArray<MiewahAsset *> *list, NSError *error) {
        @strongify(self);
        if (error) {
            [self.loadedFailure sendNext:error];
            return;
        }
        
        // 当第一次请求时，清空数据（之前的缓存）
        if (self.skip == 0) {
            [self.items removeAllObjects];
        }
        
        BOOL shouldCache = self.items.count <= CacheItemCount;
        
        [self.items addObjectsFromArray:list];
        self.skip = self.items.count;
        [self.loadedSuccess sendNext:self.items];
        
        if (shouldCache) {
            // 最多缓存数目
            NSArray *tocache = [self.items subarrayWithRange:NSMakeRange(0, self.items.count < CacheItemCount ? self.items.count : CacheItemCount)];
            [self.service cacheList:tocache completion:^(BOOL success, NSString *errorMsg) {
#if DEBUG
                NSLog(@"cache list: %@", @(success));
                NSLog(@"cache list error msg: %@", errorMsg);
#endif
            }];
        }
    }];
}

- (void)resetFlags {
    self.skip = 0;
}

- (void)reloadData {
    [self resetFlags];
    [self loadData];
}

- (RACSubject *)readCacheCompleted {
    if (_readCacheCompleted == nil) {
        _readCacheCompleted = [[RACSubject alloc] init];
    }
    return _readCacheCompleted;
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

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
