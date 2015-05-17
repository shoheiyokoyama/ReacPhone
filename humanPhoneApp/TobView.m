//
//  TobView.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "TobView.h"

@interface TobView ()
@property (nonatomic) UILabel *startLabel;
@property (nonatomic) UILabel *startRoboLabel;
@end

@implementation TobView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
        _startLabel.textAlignment = NSTextAlignmentCenter;
        _startLabel.text = @"start";
        _startLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *testLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [_startLabel addGestureRecognizer:testLabelTap];
        [self addSubview:_startLabel];
        
        _startRoboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
        _startRoboLabel.textAlignment = NSTextAlignmentCenter;
        _startRoboLabel.text = @"start robot Version";
        _startRoboLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *testRobotLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRobotLabel:)];
        [_startRoboLabel addGestureRecognizer:testRobotLabelTap];
        [self addSubview:_startRoboLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_startLabel sizeToFit];
    CGRect labelFrame = _startLabel.frame;
    labelFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(_startLabel.frame)) / 2;
    labelFrame.origin.y = CGRectGetHeight(self.bounds) / 2;
    _startLabel.frame = labelFrame;
    
    CGRect robotLabelFrame = _startRoboLabel.frame;
    robotLabelFrame.origin.x = CGRectGetMinX(_startLabel.frame);
    robotLabelFrame.origin.y = CGRectGetMaxY(_startLabel.frame) + 30.0f;
    _startRoboLabel.frame = robotLabelFrame;
}

# pragma marl - tap Action

- (void)tapLabel:(UITapGestureRecognizer *)sender
{
    NSLog(@"Labal tapped.");
    if ([_delegate respondsToSelector:@selector(tappedLabel)]) {
        [_delegate tappedLabel];
    } else if (_delegate == nil) {
    NSLog(@"delegate nil.");
    }
}

- (void)tapRobotLabel:(UITapGestureRecognizer *)sender
{
    NSLog(@"Labal tapped.");
    if ([_delegate respondsToSelector:@selector(tappedRobotLabel)]) {
        [_delegate tappedRobotLabel];
    } else if (_delegate == nil) {
        NSLog(@"delegate nil.");
    }
}

@end
