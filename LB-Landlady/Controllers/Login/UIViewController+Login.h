//
//  UIViewController+Login.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Login)

/**
 *  由于很多模块需要先登录，所以在此封装
 *
 *  @param type      介绍信息的type, 如果为nil, 则直接present登录控制器，否则先经过InfoWebViewController，在InfoWebViewController导航条右上角有登录按钮
 *  @param callback 登录完成后的回调方法
 */
- (void)loginWithInfoType:(NSString *)type callback:(void (^)(id model))callbackHandler;

@end
