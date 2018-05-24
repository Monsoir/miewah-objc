//
//  EditExtraInfoViewModel.m
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "EditExtraInfoViewModel.h"
#import "NewMiewahAsset.h"
#import "MiewahCharacter.h"
#import "MiewahWord.h"
#import "MiewahSlang.h"

@interface EditExtraInfoViewModel()

@property (nonatomic, strong) NSArray<NSString *> *sectionNames;

@property (nonatomic, strong) RACSignal *sourceSignal;
@property (nonatomic, strong) RACSignal *sentencesSignal;
@property (nonatomic, strong) RACSignal *inputMethodsSignal;

@end

@implementation EditExtraInfoViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readExtraInfos];
    }
    return self;
}

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.sourceSignal = [RACObserve(self, source) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    self.sentencesSignal = [RACObserve(self, sentences) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    self.inputMethodsSignal = [RACObserve(self, inputMethods) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
}

- (void)readExtraInfos {
    MiewahAsset *currentAsset = [NewMiewahAsset sharedAsset].currentAsset;
    switch (self.type) {
        case MiewahItemTypeCharacter:
        {
            MiewahCharacter *temp = (MiewahCharacter *)currentAsset;
            self.inputMethods = temp.inputMethods;
            self.source = temp.source;
            self.sentences = temp.sentences;
        }
            break;
        case MiewahItemTypeWord:
        {
            MiewahWord *temp = (MiewahWord *)currentAsset;
            self.source = temp.source;
            self.sentences = temp.sentences;
        }
            break;
        case MiewahItemTypeSlang:
        {
            MiewahSlang *temp = (MiewahSlang *)currentAsset;
            self.source = temp.source;
            self.sentences = temp.sentences;
        }
            break;
            
        default:
            return;
    }
}

- (void)saveExtraInfos {
    MiewahAsset *currentAsset = [NewMiewahAsset sharedAsset].currentAsset;
    currentAsset.source = self.source;
    currentAsset.sentences = self.sentences;
    if (self.type == MiewahItemTypeCharacter) {
        MiewahCharacter *temp = (MiewahCharacter *)currentAsset;
        temp.inputMethods = self.inputMethods;
    }
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
        _sectionNames = [whole valueForKey:EditAssetExtraInfosFieldNames];
    }
    return _sectionNames;
}

- (MiewahItemType)type {
    return [NewMiewahAsset sharedAsset].type;
}

@end
