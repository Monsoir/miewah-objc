//
//  MiewahListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahListViewModel.h"

@interface MiewahListViewModel ()

@property (nonatomic, strong) NSMutableArray<MiewahAsset *> *items;

@property (nonatomic, strong) RACSubject *readCacheCompleted;
@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;
@property (nonatomic, assign) NSInteger skip;

@end

@implementation MiewahListViewModel

- (void)readCache {
    
}

- (void)loadData {
    @weakify(self);
    [self.service getListAtPageIndex:self.skip completion:^(NSArray<MiewahAsset *> *list, NSError *error) {
        @strongify(self);
        if (error) {
            [self.loadedFailure sendNext:error];
            return;
        }
        
        [self.items addObjectsFromArray:list];
        self.skip = self.items.count;
        [self.loadedSuccess sendNext:self.items];
    }];
}

- (void)resetFlags {
    self.skip = 0;
    [self.items removeAllObjects];
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
