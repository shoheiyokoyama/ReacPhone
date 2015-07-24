//
//  TopView.h
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GADBannerView.h>

@interface TopView : UIView
@property (copy) void (^tappedButton)(NSString *name);
@property (copy) void (^tappedRobotButton)();
@property (nonatomic) GADBannerView *bannerView;
@end

@interface RTButton : UIButton
@end
