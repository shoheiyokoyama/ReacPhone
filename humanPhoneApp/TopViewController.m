//
//  ViewController.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "TopViewController.h"
#import "TobView.h"
#import "ReactionViewController.h"

@interface TopViewController ()
@property (nonatomic, strong) TobView *topView;
@end

@implementation TopViewController
@synthesize topView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        topView = [[TobView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:topView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    topView.tappedButton=^(){
        ReactionViewController *con = [[ReactionViewController alloc] initWithMan:YES];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:con];
        navi.navigationBar.backgroundColor = [UIColor yellowColor];
        navi.navigationBar.tintColor = [UIColor grayColor];
        [weakSelf presentViewController:navi animated:YES completion:nil];
    };
    
    topView.tappedRobotButton=^(){
        ReactionViewController *con = [[ReactionViewController alloc] initWithMan:NO];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:con];
        navi.navigationBar.backgroundColor = [UIColor yellowColor];
        navi.navigationBar.tintColor = [UIColor grayColor];
        [weakSelf presentViewController:navi animated:YES completion:nil];
    };
}

@end
