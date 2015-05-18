//
//  ReactionViewController.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "ReactionViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
#import "ReactionView.h"

@interface ReactionViewController ()<AVAudioPlayerDelegate,ReactionViewDelegate>
@property CMMotionManager *manager;
@property (strong,nonatomic) AVAudioPlayer *firstPlayer;
@property (strong,nonatomic) AVAudioPlayer *shockSound;
@property (strong,nonatomic) AVAudioPlayer *tapSound;
@property (nonatomic) ReactionView *reactionView;
@property BOOL man;
@property BOOL acting;
@end

@implementation ReactionViewController

@synthesize reactionView;

- (instancetype)initWithMan:(BOOL)man
{
    self = [super init];
    if (self) {
        _acting = NO;
        _man = man;
        reactionView = [[ReactionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] man:_man];
        reactionView.delegate = self;
        [self.view addSubview:reactionView];
        
        NSURL *shockSoundFile = [NSURL fileURLWithPath:
                                 [[NSBundle mainBundle]pathForResource:_man ? @"man_shock" : @"robo_shock" ofType:@"mp3"]];
        self.shockSound = [[AVAudioPlayer alloc] initWithContentsOfURL:shockSoundFile error:nil];
        self.shockSound.delegate = self;
        [self.shockSound prepareToPlay];
        
        NSURL *tapSoundFile = [NSURL fileURLWithPath:
                               [[NSBundle mainBundle]pathForResource:_man ? @"man_tap" : @"robo_tap" ofType:@"wav"]];
        self.tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:tapSoundFile error:nil];
        self.tapSound.delegate = self;
        [self.tapSound prepareToPlay];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self playFirstSound];
    [self getDiviceMotionData];
}

- (void)getDiviceMotionData
{
    _manager = [[CMMotionManager alloc] init];
    
    if (_manager.deviceMotionAvailable) {
        _manager.deviceMotionUpdateInterval = 1.0 / 10.0;
        
        [_manager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error) {
                [_manager stopDeviceMotionUpdates];
                NSLog(@"error");
            }
            if (motion.rotationRate.x > 2.5) {
                [reactionView toggleImage:YES];
                _acting = YES;
                [self.shockSound play];
            } else if (motion.rotationRate.y > 2.5) {
                [reactionView toggleImage:YES];
                _acting = YES;
                [self.shockSound play];
            } else if (motion.rotationRate.z > 2.5) {
                [reactionView toggleImage:YES];
                _acting = YES;
                [self.shockSound play];
            } else {
                [reactionView toggleImage:NO];
                [self performSelector:@selector(sleepAction) withObject:nil afterDelay:10.0];
            }
        }];
    }
}

- (void)sleepAction
{
    if (!_acting) {
        //sleep
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopDeviceMotionUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)playFirstSound
{
    NSURL *soundFile;
    if (_man) {
        soundFile = [NSURL fileURLWithPath:
                            [[NSBundle mainBundle]pathForResource:@"man_init" ofType:@"wav"]];
        self.firstPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    } else {
    soundFile = [NSURL fileURLWithPath:
                        [[NSBundle mainBundle]pathForResource:@"robo_init" ofType:@"mp3"]];
    }
    self.firstPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    self.firstPlayer.delegate = self;
    [self.firstPlayer prepareToPlay];
    [self.firstPlayer play];
}

#pragma -mark ReactionViewDelegate

- (void)tappedView
{
    _acting = YES;
    [reactionView toggleImage:YES];
    [self.tapSound play];
}

@end
