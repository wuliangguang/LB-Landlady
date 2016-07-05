//
//  LoginManager.h
//  LB-Landlady
//
//  Created by 刘威振 on 3/2/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LoginStatusUnknown,
    LoginStatusSuccess, // 登录成功
    LoginStatusFail,    // 登录失败
    LogoutStatusSuccess,      // 退出登录成功
    LogoutStatusFail          // 退出登录失败
} LoginStatus;

@protocol LoginManagerProtocol <NSObject>

- (void)handleLogin:(LoginStatus)status;
@end

/**
 *  登录管理器
 */
@interface LoginManager : NSObject

@property (nonatomic, copy) void (^loginHandler)(LoginStatus status);

+ (void)loginWithCompletionHandler:(void (^)(LoginStatus status))handler;
+ (void)loginWithInfo:(NSDictionary *)info controller:(UIViewController *)controller completionHandler:(void (^)(LoginStatus status))handler;

+ (void)logoutWithCompletionHandler:(void (^)(LoginStatus status))handler;
+ (void)logoutWithInfo:(NSDictionary *)info completionHandler:(void (^)(LoginStatus status))handler;

@end
