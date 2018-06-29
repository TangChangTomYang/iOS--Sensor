//
//  YRTouchSensorController.m
//  iOS Sensor
//
//  Created by yangrui on 2018/6/28.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "YRTouchSensorController.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface YRTouchSensorController ()

@end

@implementation YRTouchSensorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)startTestBtnClick:(id)sender {
    [self test];
}



-(void)test{
    //判断设备是否支持Touch ID
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        [self showAlterWithMsg:@"不支持指纹识别"];
        return;
    }else{
        
        
        LAContext *ctx = [[LAContext alloc] init];
        
        //设置 输入密码 按钮的标题
        ctx.localizedFallbackTitle = @"验证登录密码";
        
        //设置 取消 按钮的标题 iOS10之后
        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
             ctx.localizedCancelTitle = @"取消";
        }
       
        
        //检测指纹数据库更改 验证成功后返回一个NSData对象，否则返回nil
        //ctx.evaluatedPolicyDomainState;
        
        // 这个属性应该是类似于支付宝的指纹开启应用，如果你打开他解锁之后，按Home键返回桌面，再次进入支付宝是不需要录入指纹的。因为这个属性可以设置一个时间间隔，在时间间隔内是不需要再次录入。默认是0秒，最长可以设置5分钟
        
        NSLog(@"===========> %f <=========",ctx.touchIDAuthenticationAllowableReuseDuration);
        
        ctx.touchIDAuthenticationAllowableReuseDuration = 105;
        
        NSError * error;
        __block NSString *localReason = @"传感器需要验证你的身份指纹";
        
        
        // 判断设备是否支持指纹识别
        if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
            
            // 验证指纹是否匹配，需要弹出输入密码的弹框的话：iOS9之后用 LAPolicyDeviceOwnerAuthentication ；
            // iOS9之前用LAPolicyDeviceOwnerAuthenticationWithBiometrics
            [ctx evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localReason reply:^(BOOL success, NSError * error) {
              
                if (success) {
                    NSLog(@"===指纹验证成功========" );
                }
                else{
                    
                    // 错误码 error.code
                    NSLog(@"==========指纹识别错误描述 %@",error.description);
                    
                    // -1: 连续三次指纹识别错误
                    // -2: 在TouchID对话框中点击了取消按钮
                    // -3: 在TouchID对话框中点击了输入密码按钮
                    // -4: TouchID对话框被系统取消，例如按下Home或者电源键
                    // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                    switch (error.code) {
                        case -1://LAErrorAuthenticationFailed
                            NSLog(@"===code:%ld=====已经连续三次指纹识别错误了========",error.code);
                            break;
                        case -2:
                             NSLog(@"===code:%ld=====在TouchID对话框中点击了取消按钮========",error.code);
                            break;
                        case -3:
                            NSLog(@"===code:%ld=====在TouchID对话框中点击了输入密码按钮========",error.code);
                            break;
                        case -4:
                             NSLog(@"===code:%ld=====TouchID对话框被系统取消，例如按下Home或者电源键=======",error.code);
                            break;
                        case -8:
                             NSLog(@"===code:%ld=====连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码=======",error.code);
                            break;
                        default:
                            break;
                    }
                }
            }];
        }
        else{
            
            if (error.code == -8) {
                [self showAlterWithMsg:@"由于五次识别错误TouchID已经被锁定,请前往设置界面重新启用"];
            }else{
                [self showAlterWithMsg:@"TouchID没有设置指纹,请前往设置"];
            }
        }
    }
}


- (void)showAlterWithMsg:(NSString *)message{
    UIAlertController * alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alerVC animated:YES completion:^(void){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alerVC dismissViewControllerAnimated:YES completion:nil];
        });
        
    }];
    
}


@end
