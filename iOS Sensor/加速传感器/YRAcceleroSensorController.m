//
//  YRAcceleroSensorController.m
//  iOS Sensor
//
//  Created by yangrui on 2018/6/29.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "YRAcceleroSensorController.h"
#import "YRReferenceView.h"
#import "YRMotionTool.h"

@interface YRAcceleroSensorController ()

@end

@implementation YRAcceleroSensorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self acceleratorBall];
}




//滚动小球 仿真物理学 加速计
- (void)acceleratorBall{
    
    YRReferenceView * referenceView = [[YRReferenceView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    referenceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:referenceView];
    
    YRMotionTool *tool = [YRMotionTool shareTool];
    tool.referenceView = referenceView;
    
    
    UIImageView * ellipseBallView1 = [self imgViewWithFrame:CGRectMake(30, 300, 30, 30) img:@"eyes.png"];
    UIImageView * ellipseBallView2 = [self imgViewWithFrame:CGRectMake(230, 300, 30, 30) img:@"eyes.png"];
    UIImageView * ballView3 = [self imgViewWithFrame:CGRectMake(100, 64, 40, 40) img:@"ball"];
    UIImageView * ballView4 = [self imgViewWithFrame:CGRectMake(100, 64, 28, 28) img:@"ball"];
    UIImageView * ballView5 = [self imgViewWithFrame:CGRectMake(100, 500, 28, 28) img:@"ball"];
    UIImageView * ballView6 = [self imgViewWithFrame:CGRectMake(100, 500, 40, 40) img:@"ball"];
    
 
    
    [tool addAimView:ellipseBallView1];
    [tool addAimView:ellipseBallView2];

    [tool addAimView:ballView3];
    [tool addAimView:ballView4];
    [tool addAimView:ballView5];
    [tool addAimView:ballView6];
    
    [tool run];
    
}

-(UIImageView *)imgViewWithFrame:(CGRect)frame img:(NSString *)img{
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:frame];
    imgV.image = [UIImage imageNamed:img];
    return imgV;
}

@end
