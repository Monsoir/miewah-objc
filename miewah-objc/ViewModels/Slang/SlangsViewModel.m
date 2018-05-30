//
//  SlangsViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/4.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "SlangsViewModel.h"
#import "MiewahSlang.h"
#import "MiewahSlangRequesterManager.h"
#import "SlangListResponseObject.h"

@interface SlangsViewModel ()

@property (nonatomic, strong) id<MiewahListRequestProtocol> requester;

@end

@implementation SlangsViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    self.requestSuccessHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        SlangListResponseObject *_payload = (SlangListResponseObject *)payload;
        
        // 最后一页
        self.noMoreData = [_payload.pages integerValue] == self.currentPage;
        
        BOOL shouldCache = [self shouldCacheItems:_payload.slangs];
        // 如果在第一页，且返回有数据，清空之前取回的缓存
        if (shouldCache) { [self.items removeAllObjects]; }
        
        [_payload.slangs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahSlang *slang = [[MiewahSlang alloc] initWithDictionary:obj];
            [self.items addObject:slang];
        }];
        
        if (shouldCache) {
            [DatabaseHelper cacheSlangList:[self.items copy] completion:^(BOOL success, NSString *errorMsg) {
#if DEBUG
                NSLog(@"cache characters %@", @(success));
#endif
#warning 错误处理
            }];
        }
        
        self.currentPage++;
        [self.loadedSuccess sendNext:nil];
    };
    
    [self resetFlags];
}

- (void)readCache {
    [self.items removeAllObjects];
    
    @weakify(self);
    [DatabaseHelper readSlangListCacheCompletion:^(BOOL success, NSArray<MiewahAsset *> *assets, NSString *errorMsg) {
        @strongify(self);
        if (success) {
            for (MiewahAsset *asset in assets) {
                [self.items addObject:asset];
            }
            [self.readCacheCompleted sendCompleted];
        }
#warning 错误处理
    }];
}

@synthesize requester = _requester;
- (id<MiewahListRequestProtocol>)requester {
    if (_requester == nil) {
        _requester = [[MiewahSlangRequesterManager alloc] init];
    }
    return _requester;
}

@end
