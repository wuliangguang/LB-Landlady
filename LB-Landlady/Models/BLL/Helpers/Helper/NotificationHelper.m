//
//  NotificationHelper.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/30/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "NotificationHelper.h"
#import "ZZShowMessage.h"

@implementation NotificationHelper

+ (void)registNotificationOfIncomeChangeWithObserser:(id)observer selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:s_notification_income_change object:nil];
}

+ (void)postNotificationOfIncomeChangeWithObject:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:s_notification_income_change object:object userInfo:userInfo];
}

+ (void)removeNotificationOfIncomeChangeWithObserver:(id)observer object:(id)object {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:s_notification_income_change object:object];
}

@end
