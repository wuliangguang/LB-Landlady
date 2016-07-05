//
//  RootViewController.m
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    });
    [self configureTabBarSelectedImage];
    
    /**
    CGFloat length = 10.0f;
    UIView *redPoint         = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 35, kScreenHeight -25, length, length)];
    redPoint.layer.cornerRadius = length/2.0;
    redPoint.backgroundColor = [UIColor redColor];
    self.redPointView        = redPoint;
    self.redPointView.hidden = YES;
    [self.view addSubview:redPoint];
     */
}

#pragma mark ==========Private Method ========
-(void)configureTabBarSelectedImage
{
    UITabBarItem * item1 = self.tabBar.items[0];
    UITabBarItem * item2 = self.tabBar.items[1];
    UITabBarItem * item3 = self.tabBar.items[2];
    UITabBarItem * item4 = self.tabBar.items[3];
    for (UIBarButtonItem * item in self.tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    
    item1.selectedImage = [[UIImage imageNamed:@"homeSelct"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"manageSelct"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"mamonRoomSelct"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"MineSelct"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
