//
//  ReactionView.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/05/10.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "ReactionView.h"

@interface ReactionView()

@end

@implementation ReactionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self changeInitImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)changeImage
{
    UIImageView *roboCry = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Robo02.png"]];
    roboCry.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:roboCry];
}

- (void)changeInitImage
{
    UIImageView *robo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Robo01.png"]];
    robo.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:robo];
}

@end
