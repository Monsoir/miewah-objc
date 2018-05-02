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

//@property (nonatomic, strong) NSMutableArray<MiewahCharacter *> *characters;
//
//@property (nonatomic, strong) RACSignal *noMoreDataSignal;
//
//@property (nonatomic, strong) RACSubject *loadedSuccess;
//@property (nonatomic, strong) RACSubject *loadedFailure;
//@property (nonatomic, strong) RACSubject *loadedError;
//
//@property (nonatomic, assign) NSInteger currentPage;
//@property (nonatomic, assign) BOOL noMoreData;
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
    self.requestFailureHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        NSString *message = [payload.comments componentsJoinedByString:@", "];
        [self.loadedFailure sendNext:message];
    };
    self.requestErrorHandler = ^(NSError *error) {
        @strongify(self);
        [self.loadedError sendNext:error];
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
