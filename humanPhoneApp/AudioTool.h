//
//  AudioTool.h
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/06/12.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioTool : NSObject
- (void)playPathNameSound:(NSString *)soundName;
- (void)playNameSound:(NSString *)soundName;
+ (instancetype)sharedInstance;
@end
