//
//  ReactionView.h
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/05/10.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reaction;
@protocol ReactionViewDelegate <NSObject>
@optional
- (void)tappedView;
@end

@interface ReactionView : UIView
- (void)toggleImage:(BOOL)reaction;
@property (nonatomic, weak) id<ReactionViewDelegate> delegate;
@end
