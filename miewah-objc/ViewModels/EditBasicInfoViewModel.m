//
//  EditBasicInfoViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/21.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditBasicInfoViewModel.h"
#import "NewMiewahAsset.h"
#import "MiewahCharacter.h"
#import "MiewahWord.h"
#import "MiewahSlang.h"

@interface EditBasicInfoViewModel()

@property (nonatomic, strong) NSArray<NSString *> *sectionNames;
@property (nonatomic, strong) RACSignal *enableNextSignal;

@property (nonatomic, assign) MiewahItemType type;

@end

@implementation EditBasicInfoViewModel

- (instancetype)initWithType:(MiewahItemType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    RACSignal *validItemSignal = [RACObserve(self, item) map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length > 0);
    }];
    
    RACSignal *validPronunonciationSignal = [RACObserve(self, pronunonciation) map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length > 0);
    }];
    
    RACSignal *validMeaingSignal = [RACObserve(self, meaning) map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length > 0);
    }];
    
    NSArray<RACSignal *> *signals = @[validItemSignal, validPronunonciationSignal, validMeaingSignal];
    self.enableNextSignal = [RACSignal combineLatest:signals reduce:^id _Nonnull (NSNumber *validItem, NSNumber *validPronunonciation, NSNumber *validMeaning) {
        return @([validItem boolValue] && [validPronunonciation boolValue] && [validMeaning boolValue]);
    }];
}

- (void)readBasicInfos {
    NSAssert(self.type == [NewMiewahAsset sharedAsset].type, @"view model type should be equal to new miewah asset type");
    
    MiewahAsset *currentAsset = [NewMiewahAsset sharedAsset].currentAsset;
    switch (self.type) {
        case MiewahItemTypeCharacter:
            self.item = ((MiewahCharacter *)currentAsset).character;
            break;
        case MiewahItemTypeWord:
            self.item = ((MiewahWord *)currentAsset).word;
            break;
        case MiewahItemTypeSlang:
            self.item = ((MiewahSlang *)currentAsset).slang;
            break;
            
        default:
            return;
    }
    
    self.pronunonciation = currentAsset.pronunciation;
    self.meaning = currentAsset.meaning;
}

#pragma mark - Accessors

- (NSArray<NSString *> *)sectionNames {
    if (_sectionNames == nil) {
        NSString *fileName = nil;
        switch (self.type) {
            case MiewahItemTypeCharacter:
                fileName = @"NewCharacterFieldNames";
                break;
            case MiewahItemTypeWord:
                fileName = @"NewWordFieldNames";
                break;
            case MiewahItemTypeSlang:
                fileName = @"NewSlangFieldNames";
                break;
                
            default:
                break;
        }
        if (fileName == nil) return nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        NSDictionary *whole = [NSDictionary dictionaryWithContentsOfFile:path];
        _sectionNames = [whole valueForKey:EditAssetBasicInfosFieldNames];
    }
    return _sectionNames;
}

@end
