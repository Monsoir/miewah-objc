//
//  WordsMieViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/1.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "WordsMieViewModel.h"
#import "MiewahCharacterRequestManager.h"
#import "CharacterListResponseObject.h"

@interface WordsMieViewModel ()

@property (nonatomic, strong) NSMutableArray<MiewahCharacter *> *words;

@property (nonatomic, strong) RACSignal *noMoreDataSignal;

@property (nonatomic, strong) RACSubject *loadedSuccess;
@property (nonatomic, strong) RACSubject *loadedFailure;
@property (nonatomic, strong) RACSubject *loadedError;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL noMoreData;
@property (nonatomic, strong) MiewahCharacterRequestManager *requester;

@end

@implementation WordsMieViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.noMoreDataSignal = [RACObserve(self, noMoreData) map:^id _Nullable(NSNumber * _Nullable value) {
        return value;
    }];
    
    [self resetFlags];
}

- (void)loadData {
    @weakify(self);
    
    if (self.noMoreData) return;
    
    MiewahRequestSuccess successHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        CharacterListResponseObject *_payload = (CharacterListResponseObject *)payload;
        
        // 最后一页
        self.noMoreData = [_payload.pages integerValue] == self.currentPage;
        
        [_payload.characters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MiewahCharacter *character = [[MiewahCharacter alloc] initWithDictionary:obj];
            [self.words addObject:character];
        }];
        self.currentPage++;
        [self.loadedSuccess sendNext:nil];
    };
    MiewahRequestFailure failureHandler = ^(BaseResponseObject *payload) {
        @strongify(self);
        NSString *message = [payload.comments componentsJoinedByString:@", "];
        [self.loadedFailure sendNext:message];
    };
    MiewahRequestError errorHandler = ^(NSError *error) {
        @strongify(self);
        [self.loadedError sendNext:error];
    };
    
    [self.requester getCharactersAtPage:self.currentPage
                                success:successHandler
                                failure:failureHandler
                                  error:errorHandler];
}

- (void)reloadData {
    [self resetFlags];
    [self loadData];
}

- (void)resetFlags {
    self.currentPage = 1;
    self.noMoreData = NO;
    [self.words removeAllObjects];
}

- (MiewahCharacterRequestManager *)requester {
    if (_requester == nil) {
        _requester = [[MiewahCharacterRequestManager alloc] init];
    }
    return _requester;
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

- (NSMutableArray<MiewahCharacter *> *)words {
    if (_words == nil) {
        _words = [NSMutableArray array];
    }
    return _words;
}

@end
