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
@property (nonatomic) NSDate *nowDate;
@property (nonatomic) NSDate *morningDate;
@property (nonatomic) NSDate *afternoonDate;
@property (nonatomic) NSDate *nightDate;
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
        
        _nowDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY/MM/dd"];
        NSString* dateStr = [formatter stringFromDate:_nowDate];
        NSString *morning = [NSString stringWithFormat:@"%@ %@",dateStr, @"05:00:00"];
        NSString *afternoon = [NSString stringWithFormat:@"%@ %@",dateStr, @"12:00:00"];
        NSString *night = [NSString stringWithFormat:@"%@ %@",dateStr, @"17:00:00"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        _morningDate = [dateFormatter dateFromString:morning];
        _afternoonDate = [dateFormatter dateFromString:afternoon];
        _nightDate = [dateFormatter dateFromString:night];
        
        NSLog(@"now %@",[dateFormatter stringFromDate:_nowDate]);
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
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
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
        _man ? [self sayGreeting] : [self.instance playSoundFile:@"robo_init.mp3"];
        [self getDiviceMotionData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopDeviceMotionUpdates];
    _active = YES;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _man ? [userDefaults setFloat:reactionView.statusView.progress forKey:@"manStatus"] : [userDefaults setFloat:reactionView.statusView.progress forKey:@"roboStatus"];
    [userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            if ((motion.rotationRate.x > 3.5 || motion.rotationRate.x < -3.5) && !_animation) {
                [self progressChangeValue:-0.1];
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance speak:@"痛い" rate:0.2 pitchMultiplier:1.2] : [self.instance playSoundFile:@"robo_shock.mp3"];
            } else if ((motion.rotationRate.y > 3.0 || motion.rotationRate.y < -3.0) && !_animation) {
                [self progressChangeValue:-0.1];
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance speak:@"いてえよ" rate:0.2 pitchMultiplier:0.6] : [self.instance playSoundFile:@"robo_shock.mp3"];
            } else if ((motion.rotationRate.z > 3.5 || motion.rotationRate.z < -3.5) && !_animation) {
                [self progressChangeValue:-0.1];
                [reactionView toggleImage:^(BOOL animation) {
                    _animation = animation;
                }];
                _animation = YES;
                _active = YES;
                _idling = NO;
                _man ? [self.instance speak:@"うわわわ" rate:0.2 pitchMultiplier:0.6] : [self.instance playSoundFile:@"robo_shock.mp3"];
            } else {
                if (!_idling && !_animation) {
                    [reactionView.imageView setImage:reactionView.beforImage];
                }
                if (!_callSleepAction) {
                    [self performSelector:@selector(sleepAction) withObject:nil afterDelay:10.0];
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
        [self.instance speak:@"もっと大切に扱って下さい" rate:0.2 pitchMultiplier:0.5];
        OverScreenView *overScreen = [[OverScreenView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:overScreen ];
        [_manager stopDeviceMotionUpdates];
        
        overScreen.retry=^(){
            [reactionView.statusView setProgress:0.4f animated:YES];
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
        [self.instance speak:@"goo" rate:0.1 pitchMultiplier:0.2];
        _idling = YES;
        [self progressChangeValue:0.1];
    }
    _callSleepAction = NO;
}

- (void)sayGreeting
{
    if([_nowDate compare:_morningDate] == NSOrderedDescending && [_nowDate compare:_afternoonDate] == NSOrderedAscending){
        [self.instance speak:@"おはよう" rate:0.1 pitchMultiplier:0.5];
    } else if ([_nowDate compare:_afternoonDate] == NSOrderedDescending && [_nowDate compare:_nightDate] == NSOrderedAscending){
        [self.instance speak:@"こんにちは" rate:0.1 pitchMultiplier:0.5];
    } else {
        [self.instance speak:@"こんばんわ" rate:0.1 pitchMultiplier:0.5];
    }
}

- (void)didEnterBackground:(NSNotification *)notification
{
    [reactionView toggleSleepImage];
}

#pragma -mark ReactionViewDelegate

- (void)tappedView
{
    _idling = NO;
    _active = YES;
    
    if (!_animation) {
        _animation = YES;
        _man ? [self.instance speakRandom:0.3 pitchMultiplier:0.7] : [self.instance playSoundFile:@"robo_tap.wav"];
        [reactionView toggleTapImage:^(BOOL animation) {
            _animation = animation;
        }];
    }
}

@end
