//
//  ViewController.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "TopViewController.h"
#import "TobView.h"
#import "HumanPhoneViewController.h"

@interface TopViewController ()<TopViewDelegate>
@property (nonatomic, strong) TobView *top;
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _top = [[TobView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    _top.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_top];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)tappedLabel
{
    HumanPhoneViewController *con = [[HumanPhoneViewController alloc]init];
    [self.navigationController pushViewController:con animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
