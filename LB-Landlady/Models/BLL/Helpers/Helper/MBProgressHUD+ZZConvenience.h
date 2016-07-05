//
//  MBProgressHUD+ZZConvenience.h
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/2/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ZZConvenience)

/**
 *  成功Toast 1秒后消失
 *
 *  @param message           弹出的消失
 *  @param view              Toast出现的视图
 *  @param completionHandler Toast完成后的回调
 */
+ (void)showSuccessToast:(NSString *)message inView:(UIView *)view completionHandler:(void (^)())completionHandler;

/**
 *  失败Toast 3秒后消失
 */
+ (void)showFailToast:(NSString *)message inView:(UIView *)view completionHandler:(void (^)())completionHandler;

+ (void)showToast:(NSString *)message inView:(UIView *)view timeInterval:(NSTimeInterval)interval completionHandler:(void (^)())completionHandler;

@end
