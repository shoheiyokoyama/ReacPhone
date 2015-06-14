//
//  TobView.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "TobView.h"

@interface TobView ()
@property (nonatomic) UIImageView *logoImageView;
@property (nonatomic) RTButton *startButton;
@property (nonatomic) RTButton *startRoboButton;
@end

@implementation TobView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:70/255.0 alpha:1.0];
 
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 70.0f)];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        [self addSubview:_logoImageView];
      
        _startButton = [[RTButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
        [_startButton setTitle:@"START" forState:UIControlStateNormal];
        _startButton.contentEdgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        _startButton.backgroundColor = [UIColor yellowColor];
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _startButton.titleLabel.font = [UIFont fontWithName:@"ChalkboardSE-Regular" size:18.0f];
        _startButton.layer.cornerRadius = 5.0f;
        [_startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _startButton.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButton:)];
        [_startButton addGestureRecognizer:tapGesture];
        [self addSubview:_startButton];
    
        _startRoboButton = [[RTButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
        [_startRoboButton setTitle:@"START ROBOT" forState:UIControlStateNormal];
        _startRoboButton.contentEdgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        _startRoboButton.backgroundColor = [UIColor yellowColor];
        [_startRoboButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _startRoboButton.titleLabel.font = [UIFont fontWithName:@"ChalkboardSE-Regular" size:18.0f];
        _startRoboButton.layer.cornerRadius = 5.0f;
        [_startRoboButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _startRoboButton.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRoboGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRoboButton:)];
        [_startRoboButton addGestureRecognizer:tapRoboGesture];
        [self addSubview:_startRoboButton];
        
        _bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerPortrait];
        _bannerView.adUnitID = @"ca-app-pub-9398695746908582/1848241756";
        [self addSubview:_bannerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect logoFrame = _logoImageView.frame;
    logoFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(_logoImageView.frame)) / 2;
    logoFrame.origin.y = (CGRectGetHeight(self.bounds) / 2) - 170.0f;
    _logoImageView.frame = logoFrame;
    
    CGRect Frame = _startButton.frame;
    Frame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(_startButton.frame)) / 2;
    Frame.origin.y = (CGRectGetHeight(self.bounds)) - 190.0f;
    _startButton.frame = Frame;
    
    CGRect robotFrame = _startRoboButton.frame;
    robotFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(_startRoboButton.frame)) / 2;
    robotFrame.origin.y = CGRectGetHeight(self.bounds) - 120.0f;
    _startRoboButton.frame = robotFrame;
    
    CGRect bannerFrame = _bannerView.frame;
    bannerFrame.origin.y = CGRectGetHeight(self.bounds) - _bannerView.frame.size.height;
    _bannerView.frame = bannerFrame;
}

# pragma marl - tap Action

- (void)tapButton:(UITapGestureRecognizer *)sender
{
    NSLog(@"Button tapped.");
    if(self.tappedButton){
        self.tappedButton();
    }
}

- (void)tapRoboButton:(UITapGestureRecognizer *)sender
{
    NSLog(@"Robot Button tapped.");
    if(self.tappedRobotButton){
        self.tappedRobotButton();
    }
}

@end

@interface RTButton()
@end

@implementation RTButton

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [self colorWithHsvRatio:[UIColor yellowColor] hueRatio:1.0 saturationRatio:0.6 brightnessRatio:1.4];
        static CGFloat highlightedScale = 0.9f;
        self.transform = CGAffineTransformMakeScale(highlightedScale, highlightedScale);
    } else {
        self.backgroundColor = [UIColor yellowColor];
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor =[self colorWithHsvRatio:[UIColor yellowColor] hueRatio:1.0 saturationRatio:0.6 brightnessRatio:1.4];
        static CGFloat selectedScale = 0.9f;
        self.transform = CGAffineTransformMakeScale(selectedScale, selectedScale);
    } else {
        self.backgroundColor = [UIColor yellowColor];
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }
}

- (UIColor *)colorWithHsvRatio:(UIColor *)baseColor hueRatio:(CGFloat)hueRatio saturationRatio:(CGFloat)saturationRatio brightnessRatio:(CGFloat)brightnessRatio
{
    CGFloat hue = 0;
    CGFloat saturation = 0;
    CGFloat brightness = 0;
    CGFloat alpha = 0;
    
    BOOL converted = [baseColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    if (converted) {
        return [UIColor colorWithHue:(hue * hueRatio) saturation:(saturation * saturationRatio) brightness:(brightness * brightnessRatio) alpha:alpha];
    }
    
    return nil;
}

@end
