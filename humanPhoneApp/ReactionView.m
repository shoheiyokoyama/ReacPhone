//
//  ReactionView.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/05/10.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "ReactionView.h"

@interface ReactionView()
@property (nonatomic) UIImage *beforImage;
@property (nonatomic) UIImage *reactImage;
@property (nonatomic) UIImage *sleepImage;
@property (nonatomic) UIImage *tapImage;
@property (nonatomic) UIImage *helloImage;
@property (nonatomic) UIImageView *imageView;
@property BOOL man;
@end

@implementation ReactionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];

        self.userInteractionEnabled =YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
        [self addGestureRecognizer:tapGesture];
  
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
        
        _bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerPortrait];
        _bannerView.adUnitID = @"ca-app-pub-9398695746908582/3185374153";
        [self addSubview:_bannerView];
        [self bringSubviewToFront:_bannerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bannerFrame = _bannerView.frame;
    bannerFrame.origin.y = CGRectGetHeight(self.bounds) - _bannerView.frame.size.height;
    _bannerView.frame = bannerFrame;
}

- (void)toggleImage:(BOOL)reaction
{
    [_imageView setImage:reaction ? _reactImage : _beforImage];
    [self addSubview:_imageView];
}

- (void)toggleHelloImage
{
    [_imageView setImage:_helloImage];
    [self addSubview:_imageView];
}

- (void)toggleSleepImage
{
    [_imageView setImage:_sleepImage];
    [self addSubview:_imageView];
}

- (void)toggleTapImage
{
    [_imageView setImage:_tapImage];
    [self addSubview:_imageView];
}

#pragma -mark TapAction
- (void)viewTapAction:(UITapGestureRecognizer *)recognizer
{
    if ([_delegate respondsToSelector:@selector(tappedView)]) {
        [_delegate tappedView];
    }
}

@end
