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
@property (strong,nonatomic) AVAudioPlayer *player;
@property (strong,nonatomic) AVAudioPlayer *minSound;
@property (nonatomic) ReactionView *reactionView;
@property BOOL acting;
@property BOOL callNoAction;
@end

@implementation ReactionViewController

@synthesize reactionView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _acting = NO;
        _callNoAction = NO;
        reactionView = [[ReactionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        reactionView.delegate = self;
        [self.view addSubview:reactionView];
        
        NSURL *soundFile = [NSURL fileURLWithPath:
                            [[NSBundle mainBundle]pathForResource:@"robo_shock" ofType:@"mp3"]];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
        self.player.delegate = self;
        [self.player prepareToPlay];
        
        NSURL *minsSound = [NSURL fileURLWithPath:
                            [[NSBundle mainBundle]pathForResource:@"robo_min" ofType:@"wav"]];
        self.minSound = [[AVAudioPlayer alloc] initWithContentsOfURL:minsSound error:nil];
        self.minSound.delegate = self;
        [self.minSound prepareToPlay];
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
                [self.player play];
            } else if (motion.rotationRate.y > 2.5) {
                [reactionView toggleImage:YES];
                _acting = YES;
                [self.player play];
            } else if (motion.rotationRate.z > 2.5) {
                [reactionView toggleImage:YES];
                _acting = YES;
                [self.player play];
            } else if (!_acting && _callNoAction) {
                //noAction implementation
                _acting = YES;
            } else {
                [reactionView toggleImage:NO];
                [self performSelector:@selector(noAction) withObject:nil afterDelay:10.0];
            }
        }];
    }
}

- (void)noAction
{
    _acting = NO;
    _callNoAction = YES;
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
    NSURL *soundFile = [NSURL fileURLWithPath:
                        [[NSBundle mainBundle]pathForResource:@"robo_init" ofType:@"mp3"]];
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
    [self.minSound play];
}

@end
