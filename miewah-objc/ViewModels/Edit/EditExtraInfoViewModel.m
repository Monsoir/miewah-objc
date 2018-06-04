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

#import "MiewahAudioHelper.h"
#import "MiewahFileMangerHelper.h"

@interface EditExtraInfoViewModel()

@property (nonatomic, strong) NSArray<NSString *> *sectionANames;
@property (nonatomic, strong) NSArray<NSString *> *sectionBNames;

@property (nonatomic, assign) BOOL permitRecording;
@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) RACSignal *sourceSignal;
@property (nonatomic, strong) RACSignal *sentencesSignal;
@property (nonatomic, strong) RACSignal *inputMethodsSignal;
@property (nonatomic, strong) RACSignal *recordURLSignal;
@property (nonatomic, strong) RACSignal *recordingSignal;
@property (nonatomic, strong) RACSignal *playingSignal;
@property (nonatomic, strong) RACSignal *recordFileManipulationSignal;
@property (nonatomic, strong) RACSignal *permitRecordingSignal;

@property (nonatomic, strong) RACSubject *startRecordingSubject;
@property (nonatomic, strong) RACSubject *recordingSubject;
@property (nonatomic, strong) RACSubject *finishRecordingSubject;
@property (nonatomic, strong) RACSubject *abortRecordingSubject;

@property (nonatomic, strong) NSTimer *recordTimer;
@property (nonatomic, strong) MiewahAudioHelper *audioHelper;

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
    // 这里太多对象了，在其他线程进行释放
    NSArray *signals = @[self.sourceSignal, self.sentencesSignal, self.inputMethodsSignal, self.recordURLSignal, self.recordingSignal, self.playingSignal, self.recordFileManipulationSignal, self.permitRecordingSignal];
    NSArray *subjects = @[self.startRecordingSubject, self.recordingSubject, self.finishRecordingSubject, self.abortRecordingSubject];
    
    self.sourceSignal = nil;
    self.sentencesSignal = nil;
    self.inputMethodsSignal = nil;
    self.recordingSignal = nil;
    self.playingSignal = nil;
    self.recordFileManipulationSignal = nil;
    self.permitRecordingSignal = nil;
    
    self.startRecordingSubject = nil;
    self.recordingSubject = nil;
    self.finishRecordingSubject = nil;
    self.abortRecordingSubject = nil;
    
    dispatch_async(ConcurrentQueue, ^{
        [signals class];
        [subjects makeObjectsPerformSelector:@selector(sendCompleted)];
    });
}

- (void)initializeObserverSignals {
    [super initializeObserverSignals];
    
    self.isPlaying = NO;
    self.isRecording = NO;
    
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
    
    self.recordingSignal = [RACObserve(self, isRecording) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    self.playingSignal = [RACObserve(self, isPlaying) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    self.permitRecordingSignal = [RACObserve(self, permitRecording) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    NSArray<RACSignal *> *signals = @[self.recordingSignal, self.playingSignal, self.permitRecordingSignal, self.recordURLSignal];
    self.recordFileManipulationSignal = [RACSignal combineLatest:signals reduce:^id _Nonnull (NSNumber *isRecording, NSNumber *isPlaying, NSNumber *permiteRecording, NSString *fileURL) {
        return @(![isRecording boolValue] && ![isPlaying boolValue] && [permiteRecording boolValue] && fileURL.length > 0);
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
    
    // 配置定时器
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
    
    [self.audioHelper recordAudioWithStartedBlock:^(BOOL successful, NSError *error) {
        if (successful) {
            [self.startRecordingSubject sendNext:nil];
        } else {
#warning 错误处理
            NSLog(@"error: %@", error.description);
        }
    }];
}

- (void)finishRecording {
    self.isRecording = NO;
    
    [self.recordTimer invalidate];
    _recordTimer = nil;
    
    [self.audioHelper finishRecording];
//    [self.finishRecordingSubject sendNext:nil];
}

- (void)abortRecording {
    self.isRecording = NO;
    
    [self.recordTimer invalidate];
    _recordTimer = nil;
    [self.audioHelper abortRecording];
    [self.abortRecordingSubject sendNext:nil];
}

- (void)playRecord {
    [self.audioHelper playAudioWithStartedBlock:^(BOOL successful, NSError *error) {
        if (successful) {
            self.isPlaying = YES;
        } else {
            NSLog(@"%@", error.description);
        }
    }];
}

- (void)deleteRecord {
    if (self.recordURL) {
        NSError *error = nil;
        BOOL deleteResult = [MiewahFileMangerHelper deleteFileAtPath:self.recordURL error:&error];
        if (deleteResult == NO) {
#warning 错误处理
            NSLog(@"%@", error.description);
        }
        self.recordURL = nil;
    }
}

- (void)requestRecordAuthorization {
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        self.permitRecording = granted;
    }];
}

#pragma mark - Accessors

- (MiewahAudioHelper *)audioHelper {
    if (_audioHelper == nil) {
        MiewahAudioHelper *_ = [[MiewahAudioHelper alloc] init];
        __weak typeof(self) weakSelf = self;
        
        // 录音完成
        _.recordCompletion = ^(BOOL successful, NSString *url) {
            if (successful) {
                if ([MiewahFileMangerHelper fileExistAtPath:url]) {
                    weakSelf.recordURL = url;
                    weakSelf.isRecording = NO;
                    [weakSelf.finishRecordingSubject sendNext:nil];
                }
            }
        };
        
        // 录音失败
        _.recordFailure = ^(NSError *error) {
#warning 错误处理
            NSLog(@"%@", error);
            weakSelf.isRecording = NO;
        };
        
        // 播放完成
        _.playCompletion = ^(BOOL successful) {
            weakSelf.isPlaying = NO;
        };
        
        // 播放失败
        _.playFailure = ^(NSError *error) {
            weakSelf.isPlaying = NO;
        };
        
        _audioHelper = _;
    }
    return _audioHelper;
}

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
