//
//  AudioTool.h
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/06/12.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioTool : NSObject
- (void)playSoundFile:(NSString *)fileName;
- (void)playEnglishSound:(NSString *)speakContent;
- (void)speak:(NSString *)speakContent rate:(float)rate pitchMultiplier:(float)pitchMultiplier;
- (void)speakRandom:(float)rate pitchMultiplier:(float)pitchMultiplier;
+ (instancetype)sharedInstance;
@end
