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
#import <GoogleMobileAds/GADBannerView.h>

@interface TopViewController ()
@property (nonatomic, strong) TobView *topView;
@property (nonatomic) GADBannerView *bannerView;
@end

@implementation TopViewController
@synthesize topView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        topView = [[TobView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        topView.bannerView.rootViewController = self;
        [topView.bannerView loadRequest:[GADRequest request]];
        [self.view addSubview:topView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    topView.tappedButton=^(NSString *text){
        
        if (![[text stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            ReactionViewController *con = [[ReactionViewController alloc] initWithMan:YES name:text];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:con];
            navi.navigationBar.backgroundColor = [UIColor yellowColor];
            navi.navigationBar.tintColor = [UIColor grayColor];
            [weakSelf presentViewController:navi animated:YES completion:nil];
        } else {
            [weakSelf showAlert:@"名前を入力してください"];
        }
    };
    
    topView.tappedRobotButton=^(){
        ReactionViewController *con = [[ReactionViewController alloc] initWithMan:NO];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:con];
        navi.navigationBar.backgroundColor = [UIColor yellowColor];
        navi.navigationBar.tintColor = [UIColor grayColor];
        [weakSelf presentViewController:navi animated:YES completion:nil];
    };
}

- (void)showAlert:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
