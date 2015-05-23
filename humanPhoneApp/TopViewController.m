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

@interface TopViewController ()<TopViewDelegate>
@property (nonatomic, strong) TobView *topView;
@property (nonatomic) int openCount;
@end

@implementation TopViewController
@synthesize topView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"ReacPhone";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    topView = [[TobView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    topView.delegate = self;
    [self.view addSubview:topView];
}

#pragma - mark TopViewDelegate

- (void)tappedButton
{
    ReactionViewController *con = [[ReactionViewController alloc] initWithMan:YES];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:con];
    navi.navigationBar.backgroundColor = [UIColor yellowColor];
    navi.navigationBar.tintColor = [UIColor grayColor];
    [self presentViewController:navi animated:YES completion:nil];
    
}

- (void)tappedRobotButton
{
    ReactionViewController *con = [[ReactionViewController alloc] initWithMan:NO];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:con];
    navi.navigationBar.backgroundColor = [UIColor yellowColor];
    navi.navigationBar.tintColor = [UIColor grayColor];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
