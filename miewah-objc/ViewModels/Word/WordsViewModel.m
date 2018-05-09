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
        
        [_payload.words enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahWord *word = [[MiewahWord alloc] initWithDictionary:obj];
            [self.items addObject:word];
        }];
        self.currentPage++;
        [self.loadedSuccess sendNext:nil];
    };
    
    [self resetFlags];
}

@synthesize requester = _requester;
- (id<MiewahListRequestProtocol>)requester {
    if (_requester == nil) {
        _requester = [[MiewahWordRequestManager alloc] init];
    }
    return _requester;
}

@end
