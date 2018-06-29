//
//  TableViewController.m
//  iOS Sensor
//
//  Created by yangrui on 2018/6/28.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "TableViewController.h"
#import "YRDistanceSensorController.h"
#import "YRShuiPingController.h"
#import "YRAcceleroSensorController.h"
#import "YRNOrthControllerController.h"
#import "YRGyroscopeController.h"
#import "YRLightSensorController.h"

@interface TableViewController ()

@end

@implementation TableViewController


-(void)pushVC:(UIViewController *)vc title:(NSString *)title{
    vc.title = title;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES ] ;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"sensor" sender:nil];
    }
    
    if(indexPath.row == 1){
        [self pushVC: [[YRDistanceSensorController alloc] init] title:@"距离传感器"];
    }
    
    if(indexPath.row == 2){
      [self pushVC: [[YRShuiPingController alloc] init] title:@"运动传感器-水平传感器"];
    }
    
    if(indexPath.row == 3){
      [self pushVC: [[YRAcceleroSensorController alloc] init] title:@"加速传感器-物理效应"];
    }
    
    if(indexPath.row == 4){
      [self pushVC: [[YRNOrthControllerController alloc] init] title:@"指南针"];
    }
    
    if(indexPath.row == 5){
       [self pushVC: [[YRGyroscopeController alloc] init] title:@"陀螺仪-摇一摇-计步器"];
    }
    
    if(indexPath.row == 6){
      [self pushVC: [[YRLightSensorController alloc] init] title:@"光传感器"];
    }
    
}

@end
