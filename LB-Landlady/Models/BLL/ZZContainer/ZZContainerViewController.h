//
//  ContainerViewController.h
//  ContainerDemo
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 WeiZhenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZContainerTopbar.h"
#import "ZZContainerConfiguration.h"

@interface ZZContainerViewController : UIViewController

/**
 *  使用此方法进行配置
 *
 *  @param configuration 中间对象，通过它进行配置viewControllers数组等信息
 */
- (void)makeConfiguration:(void (^)(ZZContainerConfiguration *configuration))configuration;

/**
 *  当切换controller时此方法被调用，默认是第一个控制器
 */
@property (nonatomic, readonly) void (^didChangeControllerHandler)(UIViewController *controller);

@property (nonatomic, readonly) NSArray *viewControllers;

@end
