//
//  UIViewController+ShowWeb.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/9/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "UIViewController+ShowWeb.h"
#import "InfoWebViewController.h"

@implementation UIViewController (ShowWeb)

- (void)showWebWithTitle:(NSString *)title url:(NSString *)url {
    InfoWebViewController *controller = [[InfoWebViewController alloc] init];
    controller.urlStr = url;
    controller.title = title;
    UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nivController animated:YES completion:nil];
}

@end
