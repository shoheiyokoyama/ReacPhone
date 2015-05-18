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
        NSString *bundlePath  = [[NSBundle mainBundle] bundlePath];
        NSString *beforPath   = [bundlePath stringByAppendingPathComponent:_man ? @"man.png" : @"robot.png"];
        _beforImage = [UIImage imageWithContentsOfFile:beforPath];
//        _beforImage = [UIImage imageNamed:_man ? @"man.png" : @"robot.png"];
        
        
        NSString *afterPath = [bundlePath stringByAppendingPathComponent:_man ? @"man_shock.png" : @"robot_shock.png"];
        _reactImage = [UIImage imageWithContentsOfFile:afterPath];
//        _reactImage = [UIImage imageNamed:_man ? @"man_shock.png" : @"robot_shock.png"];
        
//        NSString *sleepPath = [bundlePath stringByAppendingPathComponent:_man ? @"man_shock.png" : @"robot_shock.png"];
//        _sleepImage = [UIImage imageWithContentsOfFile:sleepPath];
        
        BOOL reaction = NO;
        [self toggleImage:reaction];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)toggleImage:(BOOL)reaction
{
    [_imageView setImage:reaction ? _reactImage : _beforImage];
    [self addSubview:_imageView];
}

- (void)toggleSleepImage
{
    [_imageView setImage:_sleepImage];
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
