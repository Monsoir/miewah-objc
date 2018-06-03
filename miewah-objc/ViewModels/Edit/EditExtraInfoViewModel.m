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

@property (nonatomic, strong) NSArray<NSString *> *sectionANames;
@property (nonatomic, strong) NSArray<NSString *> *sectionBNames;

@property (nonatomic, strong) RACSignal *sourceSignal;
@property (nonatomic, strong) RACSignal *sentencesSignal;
@property (nonatomic, strong) RACSignal *inputMethodsSignal;
@property (nonatomic, strong) RACSignal *recordURLSignal;

@property (nonatomic, strong) RACSubject *startRecordingSubject;
@property (nonatomic, strong) RACSubject *recordingSubject;
@property (nonatomic, strong) RACSubject *finishRecordingSubject;
@property (nonatomic, strong) RACSubject *abortRecordingSubject;

@property (nonatomic, strong) NSTimer *recordTimer;

@end

@implementation EditExtraInfoViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readExtraInfos];
    }
    return self;
}

- (void)dealloc {
    [_recordingSubject sendCompleted];
    [_finishRecordingSubject sendCompleted];
    [_abortRecordingSubject sendCompleted];
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
    
    self.recordURLSignal = [RACObserve(self, recordURL) map:^id _Nullable(id  _Nullable value) {
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

- (void)startRecording {
    self.isRecording = YES;
    __block NSInteger counter = RecordDuration;
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        counter--;
        if (counter < 0) {
            [self finishRecording];
        } else {
            NSDictionary *userInfo = @{@"counter": @(counter)};
            [self.recordingSubject sendNext:userInfo];
        }
    }];
    [self.startRecordingSubject sendNext:nil];
}

- (void)finishRecording {
    self.isRecording = NO;
    
    [self.recordTimer invalidate];
    _recordTimer = nil;
    
    self.recordURL = @"a";
    
    [self.finishRecordingSubject sendNext:nil];
}

- (void)abortRecording {
    self.isRecording = NO;
    
    [self.recordTimer invalidate];
    _recordTimer = nil;
    
    [self.abortRecordingSubject sendNext:nil];
}

- (void)playRecord {
    NSLog(@"play");
}

- (void)deleteRecord {
    self.recordURL = nil;
}

#pragma mark - Accessors

- (NSArray<NSString *> *)sectionANames {
    if (_sectionANames == nil) {
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
        _sectionANames = [whole valueForKey:EditAssetExtraInfosFieldNames];
    }
    return _sectionANames;
}

- (NSArray<NSString *> *)sectionBNames {
    if (_sectionBNames == nil) {
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
        _sectionBNames = [whole valueForKey:EditAssetRecordInfosFieldNames];
    }
    return _sectionBNames;
}

- (MiewahItemType)type {
    return [NewMiewahAsset sharedAsset].type;
}

- (RACSubject *)startRecordingSubject {
    if (_startRecordingSubject == nil) {
        _startRecordingSubject = [[RACSubject alloc] init];
    }
    return _startRecordingSubject;
}

- (RACSubject *)recordingSubject {
    if (_recordingSubject == nil) {
        _recordingSubject = [[RACSubject alloc] init];
    }
    return _recordingSubject;
}

- (RACSubject *)finishRecordingSubject {
    if (_finishRecordingSubject == nil) {
        _finishRecordingSubject = [[RACSubject alloc] init];
    }
    return _finishRecordingSubject;
}

- (RACSubject *)abortRecordingSubject {
    if (_abortRecordingSubject == nil) {
        _abortRecordingSubject = [[RACSubject alloc] init];
    }
    return _abortRecordingSubject;
}

@end
