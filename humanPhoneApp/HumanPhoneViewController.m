//
//  HumanPhoneViewController.m
//  humanPhoneApp
//
//  Created by Shohei Yokoyama on 2015/04/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import "HumanPhoneViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface HumanPhoneViewController ()
@property CMMotionManager *manager;
@end

@implementation HumanPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [[CMMotionManager alloc] init];
    _manager.accelerometerUpdateInterval = 0.1;
    
    if (_manager.accelerometerAvailable) {
        
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
            if (data.acceleration.x > 1.0) {
                self.view.backgroundColor = [UIColor greenColor];
            } else if (data.acceleration.y > 1.0) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                self.view.backgroundColor = [UIColor redColor];
            }
        };
        [_manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_manager stopGyroUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
