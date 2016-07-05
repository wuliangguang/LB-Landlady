//
//  MBProgressHUD+ZZConvenience.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/2/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "MBProgressHUD+ZZConvenience.h"

@implementation MBProgressHUD (ZZConvenience)

+ (void)showSuccessToast:(NSString *)message inView:(UIView *)view completionHandler:(void (^)())completionHandler {
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    [self showToast:message inView:view timeInterval:SUCCESSFUL_DELAY completionHandler:completionHandler];
}

+ (void)showFailToast:(NSString *)message inView:(UIView *)view completionHandler:(void (^)())completionHandler {
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    [self showToast:message inView:view timeInterval:ERROR_DELAY completionHandler:completionHandler];
}

+ (void)showToast:(NSString *)message inView:(UIView *)view timeInterval:(NSTimeInterval)interval completionHandler:(void (^)())completionHandler {
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, interval*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
        // [MBProgressHUD hideHUDForView:view animated:YES];
        if (completionHandler) {
            completionHandler();
        }
    });
}

@end
