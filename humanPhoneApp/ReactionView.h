//
//  ReactionView.h
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/05/10.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GADBannerView.h>

@class Reaction;
@protocol ReactionViewDelegate <NSObject>
@optional
- (void)tappedView;
@end

@interface ReactionView : UIView
typedef void (^AnimationCompletionHandler)(BOOL animation);

- (void)toggleTapImage:(AnimationCompletionHandler)completionHandler;
- (void)toggleHelloImage:(AnimationCompletionHandler)completionHandler;
- (void)toggleImage:(AnimationCompletionHandler)completionHandler;
- (void)toggleSleepImage;
- (instancetype)initWithFrame:(CGRect)frame man:(BOOL)man;
@property (nonatomic, weak) id<ReactionViewDelegate> delegate;
@property (nonatomic) GADBannerView *bannerView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIImage *beforImage;
@property (nonatomic) UIImage *reactImage;
@property (nonatomic) UIProgressView *statusView;
@end