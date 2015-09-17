//
//  MyAudioManager.h
//  AVFoundationDemo
//
//  Created by CHENG DE LUO on 15/9/15.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^didPlayFinish)();
typedef void(^didRecordFinish)(NSString *urlkey, NSInteger time);

@interface MyAudioManager : NSObject

+ (instancetype)shareInstance;

- (void)playWithData:(NSData *)data finish:(didPlayFinish)didFinish;

- (void)stopPlay;

- (BOOL)startRecord;

- (void)stopRecordWithBlock:(didRecordFinish)block;

- (BOOL)initRecord;

- (CGFloat)peakPowerMeter;

- (NSInteger)recordTime;

@end
