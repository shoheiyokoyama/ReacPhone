//
//  ReactionViewController.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "ReactionViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "ReactionView.h"
#import "AudioTool.h"

@interface ReactionViewController ()<ReactionViewDelegate>
@property CMMotionManager *manager;
@property (nonatomic) ReactionView *reactionView;
@property (nonatomic) BOOL man;
@property (nonatomic) BOOL active;
@property (nonatomic) BOOL animation;
@property (nonatomic) BOOL idling;
@property (nonatomic) BOOL callSleepAction;
@property (nonatomic, weak, readonly) AudioTool *instance;
@end

@implementation ReactionViewController

@synthesize reactionView;

- (instancetype)initWithMan:(BOOL)man
{
    self = [super init];
    if (self) {
        _active = NO;
        _idling = NO;
        _animation = NO;
        _callSleepAction = NO;
        _man = man;
        
        reactionView = [[ReactionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] man:_man];
        reactionView.delegate = self;
        reactionView.bannerView.rootViewController = self;
        [reactionView.bannerView loadRequest:[GADRequest request]];
        [self.view addSubview:reactionView];
    }
    return self;
}

- (AudioTool *)instance
{
    return [AudioTool sharedInstance];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [reactionView.imageView setImage:reactionView.beforImage];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"閉じる"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(closeView)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _animation = YES;
    [reactionView toggleHelloImage:^(BOOL animation) {
        _animation = animation;
    }];
    _man ? [self.instance playNameSound:@"Hello"] : [self.instance playPathNameSound:@"robo_init.mp3"];
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
        _manager.deviceMotionUpdateInterval = 1.0 / 10.0f;
        
        [_manager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error) {
                [_manager stopDeviceMotionUpdates];
                NSLog(@"error");
            }
            if ((motion.rotationRate.x > 2.5 || motion.rotationRate.x < -2.5) && !_animation) {
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance playNameSound:@"ouch"] : [self.instance playPathNameSound:@"robo_shock.mp3"];//ouch あいた！　痛い！
            } else if ((motion.rotationRate.y > 2.5 || motion.rotationRate.y < -2.5) && !_animation) {
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance playNameSound:@"Wow"] : [self.instance playPathNameSound:@"robo_shock.mp3"];
            } else if ((motion.rotationRate.z > 2.5 || motion.rotationRate.z < -2.5) && !_animation) {
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance playNameSound:@"ouch"] : [self.instance playPathNameSound:@"robo_shock.mp3"];//aargh ウワー
            } else {
                if (!_idling && !_animation) {
                    [reactionView.imageView setImage:reactionView.beforImage];
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
        [self.instance playNameSound:@"goo"];
        _idling = YES;
    }
    _callSleepAction = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopDeviceMotionUpdates];
    _active = YES;
}

#pragma -mark ReactionViewDelegate

- (void)tappedView
{
    _idling = NO;
    _active = YES;
    if (!_animation) {
        _animation = YES;
        _man ? [self.instance playNameSound:@"Hi"] : [self.instance playPathNameSound:@"robo_tap.wav"];
        [reactionView toggleTapImage:^(BOOL animation) {
            _animation = animation;
        }];
    } else {
        return;
    }
}

@end
