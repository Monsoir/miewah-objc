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
        
        [_payload.characters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:obj];
            [self.items addObject:character];
        }];
        self.currentPage++;
        [self.loadedSuccess sendNext:nil];
    };
    
    [self resetFlags];
}

@synthesize requester = _requester;
- (id<MiewahListRequestProtocol>)requester {
    if (_requester == nil) {
        _requester = [[MiewahCharacterRequestManager alloc] init];
    }
    return _requester;
}

@end
