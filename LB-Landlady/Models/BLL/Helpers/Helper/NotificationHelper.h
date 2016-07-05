//
//  NotificationHelper.h
//  LB-Landlady
//
//  Created by 刘威振 on 3/30/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 统一管理通知
 */
@interface NotificationHelper : NSObject

/**
 * 注册通知：总收入发生变化
 */
+ (void)registNotificationOfIncomeChangeWithObserser:(id)observer selector:(SEL)selector;

/**
 * 发送通知：总收入发生变化
 */
+ (void)postNotificationOfIncomeChangeWithObject:(id)object userInfo:(NSDictionary *)userInfo;

/**
 * 取消通知：总收入发生变化
 */
+ (void)removeNotificationOfIncomeChangeWithObserver:(id)observer object:(id)object;

@end
