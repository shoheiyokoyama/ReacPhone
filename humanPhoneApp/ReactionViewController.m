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
#import "OverScreenView.h"

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
//        [reactionView.bannerView loadRequest:[GADRequest request]];
        [self.view addSubview:reactionView];
        reactionView.statusView.progress = 1.0f;
        reactionView.statusView.tintColor = [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
        
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    reactionView.statusView.progress = _man ? [userDefaults floatForKey:@"manStatus"] : [userDefaults floatForKey:@"roboStatus"];
    [self progressChangeValue:0.0f];
    
    if (reactionView.statusView.progress == 0.0f) {
        [reactionView.imageView setImage:reactionView.reactImage];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!reactionView.statusView.progress == 0.0f) {
        _animation = YES;
        [reactionView toggleHelloImage:^(BOOL animation) {
            _animation = animation;
        }];
        _man ? [self.instance playNameSound:@"Hello"] : [self.instance playPathNameSound:@"robo_init.mp3"];
        [self getDiviceMotionData];
    }
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
                [self progressChangeValue:-0.1];
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance playNameSound:@"ouch"] : [self.instance playPathNameSound:@"robo_shock.mp3"];//ouch あいた！　痛い！
            } else if ((motion.rotationRate.y > 2.5 || motion.rotationRate.y < -2.5) && !_animation) {
                [self progressChangeValue:-0.1];
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance playNameSound:@"Wow"] : [self.instance playPathNameSound:@"robo_shock.mp3"];
            } else if ((motion.rotationRate.z > 2.5 || motion.rotationRate.z < -2.5) && !_animation) {
                [self progressChangeValue:-0.1];
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

- (void)progressChangeValue:(float)value
{
    reactionView.statusView.progress += value;
    
    if (reactionView.statusView.progress == 0.0f) {
        OverScreenView *overScreen = [[OverScreenView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:overScreen ];
        [_manager stopDeviceMotionUpdates];
        
        overScreen.retry=^(){
            reactionView.statusView.progress = 1.0f;
            [self getDiviceMotionData];
            reactionView.statusView.tintColor = [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
        };
    } else if (reactionView.statusView.progress < 0.2f) {
        reactionView.statusView.tintColor = [UIColor redColor];
    } else if (reactionView.statusView.progress < 0.4f) {
        reactionView.statusView.tintColor = [UIColor yellowColor];
    } else {
        reactionView.statusView.tintColor = [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
    }
}

- (void)sleepAction
{
    if (!_active) {
        [reactionView toggleSleepImage];
        [self.instance playNameSound:@"goo"];
        _idling = YES;
        [self progressChangeValue:0.1];
    }
    _callSleepAction = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopDeviceMotionUpdates];
    _active = YES;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _man ? [userDefaults setFloat:reactionView.statusView.progress forKey:@"manStatus"] : [userDefaults setFloat:reactionView.statusView.progress forKey:@"roboStatus"];
    [userDefaults synchronize];
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
