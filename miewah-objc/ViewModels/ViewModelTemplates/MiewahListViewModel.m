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

- (void)loadData {
    if (self.noMoreData) return;
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
