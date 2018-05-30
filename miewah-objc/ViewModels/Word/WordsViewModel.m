//
//  WordsViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsViewModel.h"
#import "WordListResponseObject.h"
#import "MiewahWord.h"
#import "MiewahWordRequestManager.h"

@interface WordsViewModel ()

@property (nonatomic, strong) id<MiewahListRequestProtocol> requester;

@end

@implementation WordsViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    self.requestSuccessHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        WordListResponseObject *_payload = (WordListResponseObject *)payload;
        
        // 最后一页
        self.noMoreData = [_payload.pages integerValue] == self.currentPage;
        
        BOOL shouldCache = [self shouldCacheItems:_payload.words];
        // 如果在第一页，且返回有数据，清空之前取回的缓存
        if (shouldCache) { [self.items removeAllObjects]; }
        
        [_payload.words enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahWord *word = [[MiewahWord alloc] initWithDictionary:obj];
            [self.items addObject:word];
        }];
        
        if (shouldCache) {
            [DatabaseHelper cacheWordList:[self.items copy] completion:^(BOOL success, NSString *errorMsg) {
#if DEBUG
                NSLog(@"cache words %@", @(success));
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
    [DatabaseHelper readWordListCacheCompletion:^(BOOL success, NSArray<MiewahAsset *> *assets, NSString *errorMsg) {
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
        _requester = [[MiewahWordRequestManager alloc] init];
    }
    return _requester;
}

@end
