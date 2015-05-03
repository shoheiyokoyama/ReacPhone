//
//  HumanPhoneViewController.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "HumanPhoneViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

@interface HumanPhoneViewController ()<AVAudioPlayerDelegate>
@property CMMotionManager *manager;
@property (strong,nonatomic) AVAudioPlayer *firstPlayer;
@property (strong,nonatomic) AVAudioPlayer *player;
@end

@implementation HumanPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playFirstSound];
    
    NSURL *soundFile = [NSURL fileURLWithPath:
                        [[NSBundle mainBundle]pathForResource:@"mec05" ofType:@"wav"]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    
    UIImageView *robo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Robo01.png"]];
    robo.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:robo];
    
    _manager = [[CMMotionManager alloc] init];
    _manager.accelerometerUpdateInterval = 0.1;
    
    if (_manager.accelerometerAvailable) {
        
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
            if (data.acceleration.x > 1.0) {
                [self changeImage2];
                [self.player play];
            } else if (data.acceleration.y > 1.0) {
                [self changeImage2];
                [self.player play];
            } else {
                [self changeImage1];
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

- (void)changeImage2
{
    UIImageView *roboCry = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Robo02.png"]];
    roboCry.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:roboCry];
}

- (void)changeImage1
{
    UIImageView *robo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Robo01.png"]];
    robo.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:robo];
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
