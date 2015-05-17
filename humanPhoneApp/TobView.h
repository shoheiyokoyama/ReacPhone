//
//  TobView.h
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Top;

@protocol TopViewDelegate <NSObject>
@optional
- (void)tappedLabel;
- (void)tappedRobotLabel;
@end

@interface TobView : UIView
@property (nonatomic, weak) id<TopViewDelegate> delegate;
@end
