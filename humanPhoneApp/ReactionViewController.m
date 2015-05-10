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

- (instancetype)init
{
    self = [super init];
    if (self) {
        reactionView = [[ReactionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:reactionView];
        
        NSURL *soundFile = [NSURL fileURLWithPath:
                            [[NSBundle mainBundle]pathForResource:@"mec05" ofType:@"wav"]];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
        self.player.delegate = self;
        [self.player prepareToPlay];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playFirstSound];
    [self startAccelerometerHandler];
}

- (void)startAccelerometerHandler
{
    _manager = [[CMMotionManager alloc] init];
    _manager.accelerometerUpdateInterval = 0.1;
    
    if (_manager.accelerometerAvailable) {
        
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
            if (data.acceleration.x > 1.0) {
                [reactionView changeImage];
                [self.player play];
            } else if (data.acceleration.y > 1.0) {
                [reactionView changeImage];
                [self.player play];
            } else {
                [reactionView changeInitImage];
            }
        };
        [_manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_manager stopGyroUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)playFirstSound
{
    NSURL *soundFile = [NSURL fileURLWithPath:
                        [[NSBundle mainBundle]pathForResource:@"mec02" ofType:@"mp3"]];
    _firstPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    _firstPlayer.delegate = self;
    [_firstPlayer prepareToPlay];
    [_firstPlayer play];
}
@end
