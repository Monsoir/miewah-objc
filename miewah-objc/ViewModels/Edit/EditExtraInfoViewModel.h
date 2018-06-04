//
//  EditExtraInfoViewModel.h
//  miewah-objc
//
//  Created by Christopher on 2018/5/22.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahViewModel.h"
#import "FoundationConstants.h"

@interface EditExtraInfoViewModel : MiewahViewModel

@property (nonatomic, assign, readonly) MiewahItemType type;

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sentences;
@property (nonatomic, copy) NSString *inputMethods;
@property (nonatomic, copy) NSString *recordURL;

@property (nonatomic, assign, readonly) BOOL permitRecording;
@property (nonatomic, assign, readonly) BOOL isRecording;
@property (nonatomic, assign, readonly) BOOL isPlaying;

@property (nonatomic, strong, readonly) RACSignal *sourceSignal;
@property (nonatomic, strong, readonly) RACSignal *sentencesSignal;
@property (nonatomic, strong, readonly) RACSignal *inputMethodsSignal;
@property (nonatomic, strong, readonly) RACSignal *recordingSignal;
@property (nonatomic, strong, readonly) RACSignal *recordFileManipulationSignal;
@property (nonatomic, strong, readonly) RACSignal *permitRecordingSignal;

@property (nonatomic, strong, readonly) RACSubject *startRecordingSubject;
@property (nonatomic, strong, readonly) RACSubject *recordingSubject;
@property (nonatomic, strong, readonly) RACSubject *finishRecordingSubject;
@property (nonatomic, strong, readonly) RACSubject *abortRecordingSubject;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionANames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionBNames;

- (void)readExtraInfos;
- (void)saveExtraInfos;

- (void)startRecording;
- (void)finishRecording;
- (void)abortRecording;

- (void)playRecord;
- (void)deleteRecord;

- (void)requestRecordAuthorization;

@end
