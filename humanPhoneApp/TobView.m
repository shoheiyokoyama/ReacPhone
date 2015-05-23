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
@property (nonatomic) UIButton *startButton;
@property (nonatomic) UIButton *startRoboButton;

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
      
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
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
    
        _startRoboButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
        [_startRoboButton setTitle:@"start robot Version" forState:UIControlStateNormal];
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
    robotFrame.origin.y = (CGRectGetHeight(self.bounds)) - 120.0f;
    _startRoboButton.frame = robotFrame;
}

# pragma marl - tap Action

- (void)tapButton:(UITapGestureRecognizer *)sender
{
    NSLog(@"Labal tapped.");
    if ([_delegate respondsToSelector:@selector(tappedButton)]) {
        [_delegate tappedButton];
    } else if (_delegate == nil) {
    NSLog(@"delegate nil.");
    }
}

- (void)tapRoboButton:(UITapGestureRecognizer *)sender
{
    NSLog(@"Labal tapped.");
    if ([_delegate respondsToSelector:@selector(tappedRobotButton)]) {
        [_delegate tappedRobotButton];
    } else if (_delegate == nil) {
        NSLog(@"delegate nil.");
    }
}

@end
