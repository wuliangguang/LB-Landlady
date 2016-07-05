//
//  UIViewController+Login.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "UIViewController+Login.h"
#import "InfoWebViewController.h"

@implementation UIViewController (Login)

- (void)loginWithInfoType:(NSString *)type callback:(void (^)(id model))callbackHandler {
    if (type) {
        InfoWebViewController *webController = [[InfoWebViewController alloc] init];
        webController.callbackHandler = callbackHandler;
        webController.urlStr = [NSString stringWithFormat:@"%@%@", [URLService getIntroduceUrl], type];
        UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:webController];
        [self presentViewController:nivController animated:YES completion:nil];
    } else {
        LoginViewController *loginController = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
        if (callbackHandler) {
            loginController.callbackHandler = callbackHandler;
        }
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

@end
