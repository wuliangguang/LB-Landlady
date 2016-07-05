//
//  LoginManager.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/2/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "LoginManager.h"
#import "NSUserDefaults+Helper.h"
#import "RootViewController.h"
#import "URLService.h"
#import "CommonModel.h"
#import "MyInfoDataModel.h"
#import "MyMessageManager.h"
#import "MerchantInfoManager.h"

@implementation LoginManager

static LoginManager *_loginManager = nil;

+ (instancetype)sharedLoginManager {
    if (_loginManager == nil) {
        _loginManager = [[LoginManager alloc] init];
    }
    return _loginManager;
}

+ (void)loginWithCompletionHandler:(void (^)(LoginStatus status))handler {
    NSUserDefaults *userDefaults       = [NSUserDefaults standardUserDefaults];
    NSString *username                 = userDefaults.username;
    NSString *password                 = userDefaults.password;
    if (username && password)
    {
        /**
         *  NSString *businessId = App_User_Info.myInfo.user.business_bound;
         NSString *queryType = @"total";
         NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
         NSString *sign = [NSString stringWithFormat:@"%@%@%@",businessId,queryType,key];
         sign = [sign mdd5];
         */
        NSDate *date = [[NSDate alloc]init];
        NSString *serNum = [NSString toUUIDString];
        NSString *source = @"app";
        NSString *reqTime;
        reqTime = [date toString];
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@",username,password,reqTime,serNum,source,s_key];
        sign = [sign mdd5];
        NSDictionary *info = @{@"mobile" : username, @"password" : password,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
       // NSLog(@"-------------------info:%@",info);
        [self loginWithInfo:info controller:nil completionHandler:handler];
    }
}

+ (void)loginWithInfo:(NSDictionary *)info controller:(UIViewController *)controller completionHandler:(void (^)(LoginStatus status))handler {
    RootViewController *rootController = (RootViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    if (controller == nil) {
        controller = rootController;
    }
    LoginManager *loginManager = [LoginManager sharedLoginManager];
    loginManager.loginHandler  = handler;
    [S_R LB_PostWithURLString:[URLService logIn] WithParams:info WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"-------登陆:%@", responseString);
        dispatch_async(dispatch_get_main_queue(), ^{
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MyInfoDataModel class]];
            if (commonModel.code == SUCCESS_CODE) {
                // 保存登录后的用户信息
                MyInfoDataModel *dataModel = (MyInfoDataModel *)commonModel.data;
                App_User_Info.myInfo = dataModel;
                App_User_Info.haveLogIn = YES;
                NSLog(@"---------------------------------App_User_Info.myInfo:%@",App_User_Info.myInfo.businessModel.businessId);
                // 我的消息
                [MyMessageManager handleMessage];
                
                if (loginManager.loginHandler)
                {
                    loginManager.loginHandler(LoginStatusSuccess);
                }
                [self refreshViewControllers:LoginStatusSuccess];
            }
            else
            {
                if (loginManager.loginHandler)
                {
                    loginManager.loginHandler(LoginStatusFail);
                }
                [self refreshViewControllers:LoginStatusFail];
            }
        });
    } failure:^(NSError *error) {
        if (loginManager.loginHandler)
        {
            loginManager.loginHandler(LoginStatusFail);
            [self refreshViewControllers:LoginStatusFail];
        }
    } WithController:controller];
    
}

+ (void)logoutWithCompletionHandler:(void (^)(LoginStatus status))handler {
    [self logoutWithInfo:nil completionHandler:handler];
}

+ (void)logoutWithInfo:(NSDictionary *)info completionHandler:(void (^)(LoginStatus status))handler {
    // 服务器还没有给退出登录接口
    [App_User_Info clearCache];
    [NSUserDefaults standardUserDefaults].username = nil;
    [NSUserDefaults standardUserDefaults].password = nil;

    [self refreshViewControllers:LogoutStatusSuccess];
}

+ (void)refreshViewControllers:(LoginStatus)status {
    //UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    if ([controller isKindOfClass:[RootViewController class]] == NO) {
//        return;
//    }
    RootViewController *rootController = (RootViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    for (UINavigationController *nivController in rootController.viewControllers) {
        UIViewController *controller = nivController.viewControllers[0];
        if ([controller conformsToProtocol:@protocol(LoginManagerProtocol)] && [controller respondsToSelector:@selector(handleLogin:)]) {
            UIViewController<LoginManagerProtocol> *conformController = (UIViewController<LoginManagerProtocol> *)controller;
            if (conformController.isViewLoaded) {
                [conformController handleLogin:status];
            }
        }
        if ([controller conformsToProtocol:@protocol(MerchantInfoManagerProtocol)] && [controller respondsToSelector:@selector(handleMerchantInfo:)]) {
            UIViewController<MerchantInfoManagerProtocol> *conformController = (UIViewController<MerchantInfoManagerProtocol> *)controller;
            if (conformController.isViewLoaded && App_User_Info.myInfo.userModel.defaultBusiness.length > 0) {
                [conformController handleMerchantInfo:MerchantInfoStatusSuccess];
            }
        }
    }
    _loginManager = nil; // 优化内存，完成任务后结束自己
}

@end
