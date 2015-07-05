//
//  ReactionView.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/05/10.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "ReactionView.h"

@interface ReactionView()
@property (nonatomic) UIImage *sleepImage;
@property (nonatomic) UIImage *tapImage;
@property (nonatomic) UIImage *helloImage;
@property BOOL man;
@end

@implementation ReactionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];

        self.userInteractionEnabled =YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
        [self addGestureRecognizer:tapGesture];
        
        _statusView = [[UIProgressView alloc]initWithFrame:CGRectZero];
        [self addSubview:_statusView];
  
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame man:(BOOL)man
{
    self = [self initWithFrame:frame];
    if (self) {
        _man = man;
        _beforImage = [UIImage imageNamed:_man ? @"nomal" : @"robo_nomal"];
        _reactImage = [UIImage imageNamed:_man ? @"shock" : @"robo_shock"];
        _sleepImage = [UIImage imageNamed:_man ? @"sleep" : @"robo_sleep"];
        _helloImage = [UIImage imageNamed:_man ? @"hello" : @"robo_hello"];
        _tapImage = [UIImage imageNamed:_man ? @"tap" : @"robo_hello"];
        
//        _bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerPortrait];
//        _bannerView.adUnitID = @"ca-app-pub-9398695746908582/3185374153";
//        [self addSubview:_bannerView];
//        [self bringSubviewToFront:_bannerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bannerFrame = _bannerView.frame;
    bannerFrame.origin.y = CGRectGetHeight(self.bounds) - _bannerView.frame.size.height;
    _bannerView.frame = bannerFrame;
    
    CGRect statusFrame = _statusView.frame;
    statusFrame.size.width = CGRectGetWidth(self.bounds) - 100.0f;
    statusFrame.origin.y = CGRectGetHeight(self.bounds) - 30.0f;
    statusFrame.origin.x = (CGRectGetWidth(self.bounds) - _statusView.frame.size.width) / 2;
    _statusView.frame = statusFrame;
}

- (void)toggleImage:(AnimationCompletionHandler)completionHandler
{
    [self imageAnimation:_reactImage animateScale:1.3f completionHandler:completionHandler];
}

- (void)toggleHelloImage:(AnimationCompletionHandler)completionHandler
{
    [self imageAnimation:_helloImage animateScale:1.2f completionHandler:completionHandler];
}


- (void)toggleSleepImage
{
    [_imageView setImage:_sleepImage];
}

- (void)toggleTapImage:(AnimationCompletionHandler)completionHandler
{
    [self imageAnimation:_tapImage animateScale:1.3f completionHandler:completionHandler];
}

- (void)imageAnimation:(UIImage *)image animateScale:(CGFloat)animateScale completionHandler:(AnimationCompletionHandler)completionHandler
{
    [_imageView setImage:image];
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         _imageView.transform = CGAffineTransformMakeScale(animateScale, animateScale);
                         _imageView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished){
                         if (completionHandler) {
                             completionHandler(NO);
                         }
                     }];

}

#pragma -mark TapAction
- (void)viewTapAction:(UITapGestureRecognizer *)recognizer
{
    if ([_delegate respondsToSelector:@selector(tappedView)]) {
        [_delegate tappedView];
    }
}

@end
