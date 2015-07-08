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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AudioTool alloc]init];
    });
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

- (void)playSoundFile:(NSString *)fileName
{
    NSString *soundPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
    NSURL *urlSound = [NSURL fileURLWithPath:soundPath];
    
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSound error:nil];
    [player setNumberOfLoops:0];
    player.delegate = self;
    [_soundArray insertObject:player atIndex:0];
    [player prepareToPlay];
    [player play];
}

- (void)playEnglishSound:(NSString *)speakContent;
{
    [_fliteController say:speakContent withVoice:_slt];
}

- (void)speak:(NSString *)speakContent rate:(float)rate pitchMultiplier:(float)pitchMultiplier
{
    AVSpeechSynthesizer* speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    NSString* speakingText = speakContent;
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:speakingText];
    utterance.rate = rate; //0.0〜1.0
    utterance.pitchMultiplier = pitchMultiplier; //0.5〜2.0
    utterance.volume = 0.5f; //0.0〜1.0
    [speechSynthesizer speakUtterance:utterance];
}

- (void)speakRandom:(float)rate pitchMultiplier:(float)pitchMultiplier
{
    AVSpeechSynthesizer* speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    NSArray *array = [NSArray arrayWithObjects:@"お!", @"なんだよ", @"なんだし", @"なんだね", @"よ", @"暇なの?", @"何ですか?", @"はい!", @"ご用は何ですか？", nil];
    int randomNummber = rand() % array.count;
    NSString *speakContent = [array objectAtIndex:randomNummber];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:speakContent];
    utterance.rate = rate; //0.0〜1.0
    utterance.pitchMultiplier = pitchMultiplier; //0.5〜2.0
    utterance.volume = 0.5f; //0.0〜1.0
    [speechSynthesizer speakUtterance:utterance];
}

@end
