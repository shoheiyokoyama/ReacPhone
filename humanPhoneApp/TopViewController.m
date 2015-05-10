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
@end

@implementation TopViewController
@synthesize topView;

- (void)viewDidLoad {
    [super viewDidLoad];
    topView = [[TobView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    topView.delegate = self;
    [self.view addSubview:topView];
}

- (void)tappedLabel
{
    ReactionViewController *con = [[ReactionViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
