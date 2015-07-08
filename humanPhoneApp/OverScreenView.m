//
//  OverScreenView.m
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/07/05.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "OverScreenView.h"

@interface OverScreenView()
@property (nonatomic) UILabel *warningLabel;
@property (nonatomic) UIButton *retrybutton;
@end

@implementation OverScreenView
@synthesize warningLabel;
@synthesize retrybutton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0.7f];
        
        warningLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        warningLabel.textColor = [UIColor whiteColor];
        warningLabel.font = [UIFont boldSystemFontOfSize: 15.0f];
        warningLabel.text = @"もっと大切に扱って!";
        [self addSubview:warningLabel];
        
        retrybutton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
        [retrybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        retrybutton.titleLabel.font = [UIFont boldSystemFontOfSize: 15.0f];
        [retrybutton setTitle:@"OK" forState:UIControlStateNormal];
        retrybutton.backgroundColor = [UIColor clearColor];
        retrybutton.contentEdgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        retrybutton.layer.cornerRadius = 5.0f;
        retrybutton.layer.borderColor = [UIColor whiteColor].CGColor;
        retrybutton.layer.borderWidth = 2.0f;
        [retrybutton setTitleColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0f] forState:UIControlStateHighlighted];
        
        retrybutton.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButton:)];
        [retrybutton addGestureRecognizer:tapGesture];
        [self addSubview:retrybutton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [warningLabel sizeToFit];
    CGRect warningFrame = warningLabel.frame;
    warningFrame.origin.x = (CGRectGetWidth(self.bounds) - warningLabel.frame.size.width) / 2;
    warningFrame.origin.y = (CGRectGetHeight(self.bounds) - warningLabel.frame.size.height) / 2;
    warningLabel.frame = warningFrame;
    
    CGRect retryFrame = retrybutton.frame;
    retryFrame.origin.x = (CGRectGetWidth(self.bounds) - retrybutton.frame.size.width) / 2;
    retryFrame.origin.y = CGRectGetMaxY(warningLabel.frame) + 30.0f;
    retrybutton.frame = retryFrame;
    
}

- (void)tapButton:(UITapGestureRecognizer *)sender
{
    NSLog(@"Button tapped.");
    
    if(self.retry){
        self.retry();
    }
    [self removeFromSuperview];
}

@end
