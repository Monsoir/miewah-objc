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
@property (nonatomic, strong) RACSubject *readFavoredCompleted;
@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;
@property (nonatomic, strong) NSMutableSet<RACSubject *> *racSubjects;

/**
 从 server 获取的 skip
 */
@property (nonatomic, assign) NSInteger skip;

/**
 从 favor 获取的 skip
 */
@property (nonatomic, assign) NSInteger favordSkip;

@end

@implementation MiewahListViewModel

+ (instancetype)viewModelOfType:(MiewahItemType)type {
    Class viewModelClass = nil;
    switch (type) {
        case MiewahItemTypeCharacter:
            viewModelClass = NSClassFromString(@"CharacterListViewModel");
            break;
        case MiewahItemTypeWord:
            viewModelClass = NSClassFromString(@"WordListViewModel");
            break;
        case MiewahItemTypeSlang:
            viewModelClass = NSClassFromString(@"SlangListViewModel");
            
        default:
            break;
    }
    if (viewModelClass == nil) return nil;
    return [[viewModelClass alloc] init];
}

- (void)dealloc {
    
    _readCacheCompleted = nil;
    _readFavoredCompleted = nil;
    _loadedSuccess = nil;
    _loadedFailure = nil;
    
    NSSet *garbage = [self.racSubjects copy];
    self.racSubjects = nil;
    
    dispatch_async(ConcurrentQueue, ^{
        [garbage makeObjectsPerformSelector:@selector(sendCompleted)];
    });
    
#if DEBUG
    NSLog(@"%@ deallocs", [self class]);
#endif
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
    self.favordSkip = 0;
}

- (void)reloadData {
    [self resetFlags];
    [self loadData];
}

- (void)readFavored {
    if (self.skip == 0) {
        // 从第一页读取 || 重置了
        [self.items removeAllObjects];
    }
    
    @weakify(self);
    [self.service readAssetListFromFavoredSkip:self.skip count:10 completion:^(NSArray<MiewahAsset *> *list, NSString *errorMsg) {
        @strongify(self);
        if (errorMsg.length == 0) {
            [self.items addObjectsFromArray:list];
            self.skip = self.items.count;
            [self.readFavoredCompleted sendNext:list];
        }
#warning 错误处理
    }];
}

- (RACSubject *)readCacheCompleted {
    if (_readCacheCompleted == nil) {
        _readCacheCompleted = [[RACSubject alloc] init];
        [self.racSubjects addObject:_readCacheCompleted];
    }
    return _readCacheCompleted;
}

- (RACSubject *)readFavoredCompleted {
    if (_readFavoredCompleted == nil) {
        _readFavoredCompleted = [[RACSubject alloc] init];
        [self.racSubjects addObject:_readFavoredCompleted];
    }
    return _readFavoredCompleted;
}

- (RACSubject *)loadedSuccess {
    if (_loadedSuccess == nil) {
        _loadedSuccess = [[RACSubject alloc] init];
        [self.racSubjects addObject:_loadedSuccess];
    }
    return _loadedSuccess;
}

- (RACSubject *)loadedFailure {
    if (_loadedFailure == nil) {
        _loadedFailure = [[RACSubject alloc] init];
        [self.racSubjects addObject:_loadedFailure];
    }
    return _loadedFailure;
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableSet<RACSubject *> *)racSubjects {
    if (_racSubjects == nil) {
        _racSubjects = [NSMutableSet set];
    }
    return _racSubjects;
}

@end
