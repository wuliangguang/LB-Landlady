//
//  ConfigurationItem.m
//  MeZoneB
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import "ConfigurationItem.h"
#import "IQKeyboardManager.h"
#import "CustomImage.h"

@implementation ConfigurationItem
+ (void)initializeInfomation
{
    /**
     *  status Bar
     */
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    
    /**
     * Navigation BackgroundColor
     */
    [[UINavigationBar appearance] setBackgroundImage:[CustomImage imageWithColor:[UIColor whiteColor] size:CGSizeMake([[UIScreen mainScreen] currentMode].size.width, 64)]  forBarMetrics:UIBarMetricsDefault];
    
    /**
     *  Navigation Title Color
     */
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor], NSForegroundColorAttributeName, nil]];

    /**
     *  统一导航条系统返回按钮图片，并通过偏移隐藏标题
     */
    UIImage *backImage = [[UIImage imageNamed:@"back_arrow"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    /**
     *  键盘管理
     */
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    // [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:0];
    
    /**
     *  通知
     */
    if (IOS7)
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        
    }
    else
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    }
}
@end
