//
//  MiewahListViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahListViewModel.h"

@interface MiewahListViewModel ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) RACSignal *noMoreDataSignal;

@property (nonatomic, strong) RACSubject *readCacheCompleted;
@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;
@property (nonatomic, strong) RACSubject *loadedError;

@end

@implementation MiewahListViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.noMoreDataSignal = [RACObserve(self, noMoreData) map:^id _Nullable(NSNumber * _Nullable value) {
        return value;
    }];
}

- (void)readCache {
    
}

- (void)loadData {
    if (self.noMoreData) return;
    
    @weakify(self);
    if (_requestFailureHandler == nil) {
        _requestFailureHandler = ^(BaseResponseObject *payload) {
            @strongify(self);
            [self.loadedFailure sendNext:[payload.comments componentsJoinedByString:@", "]];
        };
    }
    
    if (_requestErrorHandler == nil) {
        _requestErrorHandler = ^(NSError *error) {
            @strongify(self);
            [self.loadedError sendNext:error];
        };
    }
    
    [self.requester getListAtPage:self.currentPage
                     success:self.requestSuccessHandler
                     failure:self.requestFailureHandler
                       error:self.requestErrorHandler];
}

- (void)resetFlags {
    self.noMoreData = NO;
    self.currentPage = 1;
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

- (RACSubject *)loadedError {
    if (_loadedError == nil) {
        _loadedError = [[RACSubject alloc] init];
    }
    return _loadedError;
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end

@implementation MiewahListViewModel(Cache)

- (BOOL)shouldCacheItems:(id)items {
    return self.currentPage == 1 && [items respondsToSelector:@selector(count)] && [items count] > 0;
}

@end
