//
//  CharactersViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/2.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharactersViewModel.h"
#import "MiewahCharacterRequestManager.h"
#import "CharacterListResponseObject.h"
#import "MiewahCharacter.h"

@interface CharactersViewModel ()

@property (nonatomic, strong) id<MiewahListRequestProtocol> requester;

@end

@implementation CharactersViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    @weakify(self);
    
    self.requestSuccessHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        
        CharacterListResponseObject *_payload = (CharacterListResponseObject *)payload;
        
        // 最后一页
        self.noMoreData = [_payload.pages integerValue] == self.currentPage;
        
        BOOL shouldCache = [self shouldCacheItems:_payload.characters];
        // 如果在第一页，且返回有数据，清空之前取回的缓存
        if (shouldCache) { [self.items removeAllObjects]; }
        
        [_payload.characters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:obj];
            [self.items addObject:character];
        }];
        
        if (shouldCache) {
            [DatabaseHelper cacheCharacterList:[self.items copy] completion:^(BOOL success, NSString *errorMsg) {
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
    [DatabaseHelper readCharacterListCacheCompletion:^(BOOL success, NSArray<MiewahAsset *> *assets, NSString *errorMsg) {
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
        _requester = [[MiewahCharacterRequestManager alloc] init];
    }
    return _requester;
}

@end
