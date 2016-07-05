//
//  AppDelegate.m
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigurationItem.h"
#import "NSUserDefaults+Helper.h"
#import "CommonModel.h"
#import "MyInfoDataModel.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MyMessageManager.h"
#import "RootViewController.h"
#import "LoginManager.h" // 登录器
#import "JPUSHService.h"
#import "ZZShowMessage.h"
#import "DirectivePageViewController.h"
#import "HomeViewController.h"

#define isProduction YES

@interface AppDelegate ()<BMKGeneralDelegate>
@property (nonatomic, strong) BMKMapManager* mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /**
     app 全局ui配置
     - returns: nil
     */
    [ConfigurationItem initializeInfomation];
    self.mapManager = [[BMKMapManager alloc] init];
    //    BOOL ret = [_mapManager start:@"5irNH8n434OjEUVfbFVRmUEL"  generalDelegate:self];
    BOOL ret = [_mapManager start:@"NgQCrgYuCUguRGsP1Zju92W8"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

//    // 极光推送
//    // Required
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
//    } else {
//        // categories必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
//    }
//    
//    [JPUSHService setupWithOption:launchOptions appKey:s_jpush_app_key channel:@"Publish channel App Store" apsForProduction:isProduction]; // 如果是发布版本,此处改为YES
    
    // UIApplication:setApplicationIconBadgeNumber
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if ([[NSUserDefaults standardUserDefaults] didAccess] == NO) {
    
        DirectivePageViewController *directController = [[DirectivePageViewController alloc] init];
        self.window.rootViewController = directController;
        __weak typeof(self) weakSelf = self;
        directController.endCallback = ^{
            UIStoryboard * SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HomeViewController * homeVC = [SB instantiateInitialViewController];
            weakSelf.window.rootViewController = homeVC;
        };
    }
    
    
    return YES;
}

// 注册, 把deviceToken给jpush
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
   // [JPUSHService registerDeviceToken:deviceToken];
}

//// 接收到远和推送消息
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    /**
//     {
//     "_j_msgid" = 1605533585;
//     aps =     {
//     alert = "\U5927\U5218";
//     badge = 1;
//     sound = default;
//     };
//     }
//     */
//    // Required,For systems with less than or equal to iOS6
//    [JPUSHService handleRemoteNotification:userInfo];
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
}

//// 接收远程推送消息失败
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    //Optional
//  //  NSLog(@"did Fail To Register For Remote Notifications With Error: %@",
//      //    error);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self logOut];
}

- (void)logOut {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 检查更新
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [S_R appCheckUpdate:871676479];
    });
}

/**
- (void)logIn {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (userDefault.username && userDefault.password) {
        NSString * urlStr = [URLService logIn];
        [S_R LB_GetWithURLString:urlStr WithParams:@{@"phone" : userDefault.username, @"password" : userDefault.password} WithSuccess:^(id responseObject, id responseString) {
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MyInfoDataModel class]];
            if (commonModel.code == SUCCESS_CODE) { // 如果登录成功
                MyInfoDataModel *dataModel    = (MyInfoDataModel *)commonModel.data;
                App_User_Info.myInfo          = dataModel;
                App_User_Info.haveLogIn       = YES;
                
                // 我的消息
                [MyMessageManager handleMessage];
            }
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error);
        } WithController:self.window.rootViewController];
    }
}*/

//- (void)logIn {
//    [LoginManager loginWithCompletionHandler:nil];
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
