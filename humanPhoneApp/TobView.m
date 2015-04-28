//
//  TobView.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "TobView.h"

@interface TobView ()
@property (nonatomic) UILabel *testLabel;
@end

@implementation TobView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.textAlignment = NSTextAlignmentCenter;
        _testLabel.text = @"tap here!!";
        _testLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *testLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [_testLabel addGestureRecognizer:testLabelTap];
        [self addSubview:_testLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _testLabel.frame = CGRectMake((self.bounds.size.width - 100.0f) / 2, (self.bounds.size.height - 40.0f) / 2 , 100.0f, 40.0f);
    [_testLabel sizeToFit];
}

# pragma marl - tap Action

- (void)tapLabel:(UITapGestureRecognizer *)sender
{
    NSLog(@"Test Labal tapped.");
    if ([_delegate respondsToSelector:@selector(tappedLabel)]) {
        [_delegate tappedLabel];
    } else if (_delegate ==nil) {
    NSLog(@"delegate nil.");
    }
}

@end
