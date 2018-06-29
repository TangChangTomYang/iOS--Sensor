//
//  YRDistanceSensorController.m
//  iOS Sensor
//
//  Created by yangrui on 2018/6/29.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "YRDistanceSensorController.h"
#import <AVFoundation/AVFoundation.h>

@interface YRDistanceSensorController ()
{
    AVPlayer * _play;
}
@end

@implementation YRDistanceSensorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self testDistanceSensor];
}



//距离传感器 感应是否有其他物体靠近屏幕,
//iPhone手机中内置了距离传感器，位置在手机的听筒附近，
//当我们在打电话或听微信语音的时候靠近听筒，手机的屏幕会自动熄灭，这就靠距离传感器来控制
- (void)testDistanceSensor{
    
    // 打开距离传感器
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    // 通过通知监听有物品靠近还是离开
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"SeeYouAgain" ofType:@"mp3"];
    if(path == nil){
        return;
    }
    _play = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
    
    [_play play];
    
}

- (void)proximityStateDidChange:(NSNotification *)note
{
    if ([UIDevice currentDevice].proximityState) {
        NSLog(@"=======有东西靠近=========");
        //听筒播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    } else {
        NSLog(@"=========有物体离开========");
        //扬声器播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

- (void)dealloc{
    [_play pause];
    _play = nil;
    //关闭距离传感器
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
}




@end
