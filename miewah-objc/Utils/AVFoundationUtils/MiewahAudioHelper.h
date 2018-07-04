//
//  AudioHelper.h
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^RecordCompletion)(BOOL successful, NSString *url);
typedef void(^RecordFailure)(NSError *error);

typedef void(^PlayCompletion)(BOOL successful);
typedef void(^PlayFailure)(NSError *error);

typedef void(^AudioStartedBlock)(BOOL successful, NSError *error);

@interface MiewahAudioHelper : NSObject

@property (nonatomic, copy) RecordCompletion recordCompletion;
@property (nonatomic, copy) RecordFailure recordFailure;

@property (nonatomic, copy) PlayCompletion playCompletion;
@property (nonatomic, copy) PlayFailure playFailure;

- (void)recordAudioWithStartedBlock:(AudioStartedBlock)block;
- (void)playAudioWithStartedBlock:(AudioStartedBlock)block;
- (void)resumeBackgroundSoundWithCompletionBlock:(AudioStartedBlock)block;

- (void)finishRecording;
- (void)abortRecording;

@end
