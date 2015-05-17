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
@property (nonatomic) UIImageView *imageView;
@end

@implementation ReactionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *bundlePath  = [[NSBundle mainBundle] bundlePath];
        NSString *beforPath   = [bundlePath stringByAppendingPathComponent:@"Robo01.png"];
        _beforImage = [UIImage imageWithContentsOfFile:beforPath];
        NSString *afterPath = [bundlePath stringByAppendingPathComponent:@"Robo02.png"];
        _reactImage = [UIImage imageWithContentsOfFile:afterPath];
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        BOOL reaction = NO;
        [self toggleImage:reaction];
        
        self.userInteractionEnabled =YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
        [self addGestureRecognizer:tapGesture];
  
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

#pragma -mark TapAction
- (void)viewTapAction:(UITapGestureRecognizer *)recognizer
{
    if ([_delegate respondsToSelector:@selector(tappedView)]) {
        [_delegate tappedView];
    }
}

@end
