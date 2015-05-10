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

@interface ReactionViewController ()<AVAudioPlayerDelegate>
@property CMMotionManager *manager;
@property (strong,nonatomic) AVAudioPlayer *firstPlayer;
@property (strong,nonatomic) AVAudioPlayer *player;
@property (nonatomic) ReactionView *reactionView;
@end

@implementation ReactionViewController

@synthesize reactionView;

- (instancetype)initWithCount:(int)openCount
{
    self = [super init];
    if (self) {
        reactionView = [[ReactionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:reactionView];
        
        if (openCount == 0) {
            NSURL *soundFile = [NSURL fileURLWithPath:
                                [[NSBundle mainBundle]pathForResource:@"mec05" ofType:@"wav"]];
            self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
            self.player.delegate = self;
            [self.player prepareToPlay];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self playFirstSound];
//    [self startAccelerometer];
    [self startGyro];
}

- (void)startAccelerometer
{
    _manager = [[CMMotionManager alloc] init];
    if (_manager.accelerometerAvailable) {
        _manager.accelerometerUpdateInterval = 1.0 / 10.0;
        
        [_manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *data, NSError *error) {
            if (error) {
                [_manager stopAccelerometerUpdates];
                NSLog(@"error");
            }
            if (data.acceleration.x > 1.0 || data.acceleration.x < -1.0) {
                [reactionView updateImageView:YES];
                [self.player play];
            } else if (data.acceleration.y > 1.0 || data.acceleration.y < -1.0) {
                [reactionView updateImageView:YES];
                [self.player play];
            } else if (data.acceleration.z > 1.0 || data.acceleration.z < -1.0) {
                [reactionView updateImageView:YES];
                [self.player play];
            } else {
                [reactionView updateImageView:NO];
            }
        }];
    }
}

- (void)startGyro
{
    _manager = [[CMMotionManager alloc] init];
    if (_manager.gyroAvailable) {
        _manager.gyroUpdateInterval = 1.0 / 10.0;
        [_manager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error) {
                [_manager stopAccelerometerUpdates];
                NSLog(@"error");
            }
            if (motion.rotationRate.x > 1.5) {
                [reactionView updateImageView:YES];
                [self.player play];
            } else if (motion.rotationRate.y > 1.5 || motion.rotationRate.y < -1.5) {
                [reactionView updateImageView:YES];
                [self.player play];
            } else if (motion.rotationRate.z > 1.5 || motion.rotationRate.z < -1.5) {
                [reactionView updateImageView:YES];
                [self.player play];
            } else {
                [reactionView updateImageView:NO];
            }
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_manager stopAccelerometerUpdates];
    [_manager stopGyroUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)playFirstSound
{
    NSURL *soundFile = [NSURL fileURLWithPath:
                        [[NSBundle mainBundle]pathForResource:@"mec02" ofType:@"mp3"]];
    self.firstPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    self.firstPlayer.delegate = self;
    [self.firstPlayer prepareToPlay];
    [self.firstPlayer play];
}

@end
