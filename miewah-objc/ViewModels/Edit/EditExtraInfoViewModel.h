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

@property (nonatomic, strong, readonly) RACSignal *sourceSignal;
@property (nonatomic, strong, readonly) RACSignal *sentencesSignal;
@property (nonatomic, strong, readonly) RACSignal *inputMethodsSignal;
@property (nonatomic, strong, readonly) RACSignal *recordURLSignal;

@property (nonatomic, assign) BOOL isRecording;
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

@end
