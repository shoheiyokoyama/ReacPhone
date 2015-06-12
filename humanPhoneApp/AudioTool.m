//
//  AudioTool.m
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/06/12.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "AudioTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Slt/Slt.h>
#import <OpenEars/OEFliteController.h>

@interface AudioTool()<AVAudioPlayerDelegate>
@property (strong, nonatomic) OEFliteController *fliteController;
@property (strong, nonatomic) Slt *slt;
@property (nonatomic) NSMutableArray *soundArray;
@end

@implementation AudioTool

static AudioTool *instance = nil;
+ (AudioTool *)sharedInstance
{
    @synchronized(self) {
        if (!instance) {
            instance = [[AudioTool alloc] init];
        }
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _soundArray = [[NSMutableArray alloc] init];
        _fliteController = [[OEFliteController alloc] init];
        _slt = [[Slt alloc] init];
    }
    return self;
}

- (void)playPathNameSound:(NSString *)soundName
{
    NSString *soundPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:soundName];
    NSURL *urlSound = [NSURL fileURLWithPath:soundPath];
    
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSound error:nil];
    [player setNumberOfLoops:0];
    player.delegate = self;
    [_soundArray insertObject:player atIndex:0];
    [player prepareToPlay];
    [player play];
}

- (void)playNameSound:(NSString *)soundName
{
    [_fliteController say:soundName withVoice:_slt];
}

@end
