//
//  AudioHelper.m
//  miewah-objc
//
//  Created by Christopher on 2018/6/3.
//  Copyright © 2018 wenyongyang. All rights reserved.
//

#import "MiewahAudioHelper.h"
#import "NSDateFormatter+Singleton.h"
#import "FoundationConstants.h"
#import "MiewahFileMangerHelper.h"

#define SharedAudioSession [AVAudioSession sharedInstance]

@interface MiewahAudioHelper()<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, copy) NSString *recordFilePath;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation MiewahAudioHelper

#pragma mark - Controls

- (void)recordAudioWithStartedBlock:(AudioStartedBlock)block {
    dispatch_async(ConcurrentQueue, ^{
        NSError *error = nil;
        BOOL setSessionCategoryResult = [SharedAudioSession setCategory:AVAudioSessionCategoryRecord error:&error];
        if (setSessionCategoryResult == NO) {
            block(NO, error);
            return;
        }
        BOOL setSessionActiveResult = [SharedAudioSession setActive:YES error:&error];
        if (setSessionActiveResult == NO) {
            block(NO, error);
            return;
        }
        
        BOOL recorderConfigureResult = [self configureRecorderWithError:&error];
        if (recorderConfigureResult == NO) {
            block(NO, error);
            return;
        }
        
        NSAssert(self.recorder != nil, @"recorder 为空了");
        [self.recorder prepareToRecord];
        [self.recorder record];
        block(YES, nil);
    });
}

- (void)playAudioWithStartedBlock:(AudioStartedBlock)block {
    dispatch_async(ConcurrentQueue, ^{
        NSError *error = nil;
        BOOL setSessionCategoryResult = [SharedAudioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        if (setSessionCategoryResult == NO) {
            block(NO, error);
            return;
        }
        BOOL setSessionActiveResult = [SharedAudioSession setActive:YES error:&error];
        if (setSessionActiveResult == NO) {
            block(NO, error);
            return;
        }
        
        BOOL playerConfigureResult = [self configurePlayerWithError:&error];
        if (playerConfigureResult == NO) {
            block(NO, error);
            return;
        }
        
        NSAssert(self.player != nil, @"player 为空了");
        [self.player prepareToPlay];
        [self.player play];
        block(YES, nil);
    });
}

- (void)resumeBackgroundSoundWithCompletionBlock:(AudioStartedBlock)block {
    dispatch_async(ConcurrentQueue, ^{
        NSError *error = nil;
        BOOL result = [SharedAudioSession setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
        block(result, error);
    });
}

- (void)abortRecording {
    [self.recorder stop];
    
    NSError *error = nil;
    BOOL deleteResult = [MiewahFileMangerHelper deleteFileAtPath:self.recordFilePath error:&error];
    if (deleteResult == NO) {
        NSLog(@"%@", error.description);
    }
    
    self.recordFilePath = nil;
}

- (void)finishRecording {
    [self.recorder stop];
}

#pragma mark - Configuration

- (BOOL)configureRecorderWithError:(NSError *__autoreleasing *)error {
    NSDictionary *recordSettings = [[self class] simpleRecorderSettings];
    NSString *fileName = [NSString stringWithFormat:@"%@.aac", [SharedDateFormatter stringFromDate:[NSDate new]]];
    self.recordFilePath = [TmpDirectory stringByAppendingPathComponent:fileName];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.recordFilePath] settings:recordSettings error:error];
    if (self.recorder == nil) {
        NSLog(@"%@", (*error).description);
        return NO;
    }
    
    self.recorder.meteringEnabled = YES; // 监控声波必备
    self.recorder.delegate = self;
    
    return YES;
}

- (BOOL)configurePlayerWithError:(NSError *__autoreleasing *)error {
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.recordFilePath] error:error];
    if (self.player == nil) {
        NSLog(@"%@", (*error).description);
        return NO;
    }
    self.player.delegate = self;
    return YES;
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (self.recordCompletion) {
        self.recordCompletion(flag, self.recordFilePath);
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    if (self.recordFailure) {
        self.recordFailure(error);
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (self.playCompletion) {
        self.playCompletion(flag);
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    if (self.playFailure) {
        self.playFailure(error);
    }
}

#pragma mark - Settings

+ (NSDictionary *)simpleRecorderSettings {
    return @{
             AVSampleRateKey: @8000, // 采样率
             AVFormatIDKey: @(kAudioFormatMPEG4AAC), // 格式
             AVLinearPCMBitDepthKey:  @16,
             AVNumberOfChannelsKey: @2,
             AVEncoderAudioQualityKey: @(AVAudioQualityHigh),
             };
}

@end
