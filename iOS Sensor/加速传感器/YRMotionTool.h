//
//  YRMotionTool.h
//  iOS Sensor
//
//  Created by yangrui on 2018/6/29.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRMotionTool : NSObject


//参照视图，设置仿真范围）
@property (nonatomic, weak) UIView * referenceView;

+ (instancetype)shareTool;

/** 注意在 add 前应该先添加 referenceView */
- (void)addAimView:(UIView *)ballView ;


- (void)run ;
- (void)stopMotionUpdates;

@end
