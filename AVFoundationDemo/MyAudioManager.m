//
//  MyAudioManager.m
//  AVFoundationDemo
//
//  Created by CHENG DE LUO on 15/9/15.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "MyAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@interface MyAudioManager()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSURL *recordFileUrl;
@property (nonatomic, strong) NSString *recordUrlKey;
@property (nonatomic, strong) didPlayFinish finishBlock;


@end

@implementation MyAudioManager

+ (instancetype)shareInstance
{
    static MyAudioManager *shareInstance = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        shareInstance = [[MyAudioManager alloc] init];
        [shareInstance activeAudioSession];
    });
    
    return shareInstance;
}

- (void)activeAudioSession
{
    self.session = [[AVAudioSession alloc] init];
    NSError *sessionError;
    [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    
    if (self.session) {
        NSLog(@"error=%@", sessionError);
    } else {
        [self.session setActive:YES error:nil];
    }
}

- (void)playWithData:(NSData *)data finish:(didPlayFinish)didFinish
{
    self.finishBlock = didFinish;
    
    if (self.audioPlayer) {
        if([self.audioPlayer isPlaying]) {
            [self.audioPlayer stop];
        }
        self.audioPlayer.delegate = nil;
        self.audioPlayer = nil;
    }
    
    NSError *playerError;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
    if (self.audioPlayer) {
        self.audioPlayer.delegate = self;
        [self.audioPlayer play];
    } else {
        NSLog(@"Error create player: %@", [playerError localizedDescription]);
    }
    
}

- (void)stopPlay
{
    if (self.audioPlayer) {
        if([self.audioPlayer isPlaying]) {
            [self.audioPlayer stop];
        }
        self.audioPlayer.delegate = nil;
        self.audioPlayer = nil;
    }
}

- (BOOL)startRecord
{
    return [self.audioRecorder record];
}

- (void)stopRecordWithBlock:(didRecordFinish)block
{
    NSTimeInterval time = self.audioRecorder.currentTime;
    [self.audioRecorder stop];
    if (block) {
        block(self.recordUrlKey, (NSInteger)time);
    }
}

- (BOOL)initRecord
{
    //录音设置
    NSMutableDictionary *recordSetting = [NSMutableDictionary dictionary];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@.aac", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], [self getUUID]];
    NSURL *url = [NSURL fileURLWithPath:urlstring];
    self.recordUrlKey = urlstring;
    
    NSError *error;
    self.audioRecorder  = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    
    if ([self.audioRecorder prepareToRecord]) {
        return YES;
    }
    return NO;
}

- (CGFloat)peakPowerMeter
{
    CGFloat peakPower = 0;
    peakPower = 0.5;
    return peakPower;
}

- (NSInteger)recordTime
{
    return self.audioRecorder.currentTime;
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (self.finishBlock) {
        self.finishBlock();
    }
}

#pragma mark - private methods

- (NSString *)getUUID
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef struuid = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    NSString *str = (__bridge NSString *)struuid;
    
    CFRelease(struuid);
    CFRelease(uuid);
    
    return str;
    
    
}

@end
