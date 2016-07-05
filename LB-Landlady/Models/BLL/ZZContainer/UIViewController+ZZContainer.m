//
//  UIViewController+ZZContainer.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/20/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "UIViewController+ZZContainer.h"

@implementation UIViewController (ZZContainer)

- (void)setContainerViewController:(ZZContainerViewController *)containerViewController {
    objc_setAssociatedObject(self, @selector(containerViewController), containerViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (ZZContainerViewController *)containerViewController {
    return objc_getAssociatedObject(self, _cmd);
}

@end
