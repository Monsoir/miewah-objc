//
//  CharacterEditViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "CharacterEditViewModel.h"
#import "FoundationConstants.h"

@interface CharacterEditViewModel()

@property (nonatomic, strong) NSArray<NSString *> *sectionName;
@property (nonatomic, strong) RACSignal *enableNextSignal;

@end

@implementation CharacterEditViewModel

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    RACSignal *validCharacterSignal = [RACObserve(self, character) map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length > 0);
    }];
    
    RACSignal *validPronunonciationSignal = [RACObserve(self, pronunonciation) map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length > 0);
    }];
    
    RACSignal *validMeaingSignal = [RACObserve(self, meaning) map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length > 0);
    }];
    
    NSArray<RACSignal *> *signals = @[validCharacterSignal, validPronunonciationSignal, validMeaingSignal];
    self.enableNextSignal = [RACSignal combineLatest:signals reduce:^id _Nonnull (NSNumber *validCharacter, NSNumber *validPronunonciation, NSNumber *validMeaning) {
        return @([validCharacter boolValue] && [validPronunonciation boolValue] && [validMeaning boolValue]);
    }];
}

#pragma mark - Lazy initialization
- (NSArray<NSString *> *)sectionName {
    if (_sectionName == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"NewCharacterFieldNames" ofType:@"plist"];
        NSDictionary *whole = [NSDictionary dictionaryWithContentsOfFile:path];
        _sectionName = [whole valueForKey:EditAssetBasicInfosFieldNames];
    }
    return _sectionName;
}

@end
