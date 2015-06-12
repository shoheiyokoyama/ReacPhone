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
#import <Slt/Slt.h>
#import <OpenEars/FliteController.h>

@interface ReactionViewController ()<AVAudioPlayerDelegate,ReactionViewDelegate>
@property CMMotionManager *manager;
@property (strong,nonatomic) AVAudioPlayer *firstPlayer;
@property (strong,nonatomic) AVAudioPlayer *shockSound;
@property (strong,nonatomic) AVAudioPlayer *tapSound;
@property (nonatomic) ReactionView *reactionView;
@property (nonatomic) BOOL man;
@property (nonatomic) BOOL active;
@property (nonatomic) BOOL idling;
@property (nonatomic) BOOL callSleepAction;
@end

@implementation ReactionViewController

@synthesize reactionView;

- (instancetype)initWithMan:(BOOL)man
{
    self = [super init];
    if (self) {
        _active = NO;
        _idling = NO;
        _callSleepAction = NO;
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
                               [[NSBundle mainBundle]pathForResource:_man ? @"tap" : @"robo_tap" ofType:@"wav"]];
        self.tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:tapSoundFile error:nil];
        self.tapSound.delegate = self;
        [self.tapSound prepareToPlay];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [reactionView toggleImage:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"閉じる"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(closeView)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [reactionView toggleHelloImage];
    [self playHelloSound];
    [self getDiviceMotionData];
}

- (void)closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getDiviceMotionData
{
    _manager = [[CMMotionManager alloc] init];
    
    if (_manager.deviceMotionAvailable) {
        _manager.deviceMotionUpdateInterval = (1.0 / 10.0f) * 2;
        
        [_manager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error) {
                [_manager stopDeviceMotionUpdates];
                NSLog(@"error");
            }
            if (motion.rotationRate.x > 2.0 || motion.rotationRate.x < -2.0) {
                [reactionView toggleImage:YES];
                _active = YES;
                _idling = NO;
                [self.shockSound play];
            } else if (motion.rotationRate.y > 2.0 || motion.rotationRate.y < -2.0) {
                [reactionView toggleImage:YES];
                _active = YES;
                _idling = NO;
                [self.shockSound play];
            } else if (motion.rotationRate.z > 2.0 || motion.rotationRate.z < -2.0) {
                [reactionView toggleImage:YES];
                _active = YES;
                _idling = NO;
                [self.shockSound play];
            } else {
                if (!_idling) {
                    [reactionView toggleImage:NO];
                }
                if (!_callSleepAction) {
                    [self performSelector:@selector(sleepAction) withObject:nil afterDelay:7.0];
                    _callSleepAction = YES;
                    _active = NO;
                }
            }
        }];
    }
}

- (void)sleepAction
{
    if (!_active) {
        [reactionView toggleSleepImage];
        _idling = YES;
    }
    _callSleepAction = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopDeviceMotionUpdates];
}

- (void)playHelloSound
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
    _active = YES;
    _idling = NO;
    [reactionView toggleTapImage];
    [self.tapSound play];
}

@end
