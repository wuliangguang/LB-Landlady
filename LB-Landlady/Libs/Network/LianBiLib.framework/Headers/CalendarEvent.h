//
//  CalendarEvent.h
//  FrameworkDemo
//
//  Created by wallace on 15/4/27.
//  Copyright (c) 2015年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionBlock)();
@interface CalendarEvent : NSObject

@property (nonatomic, assign) CompletionBlock successful;
@property (nonatomic, assign) CompletionBlock failure;

/*
 *需要导入架包：<EventKit/EventKit.h>
 *alarm：设置事件之前多长时候开始提醒
 *eventTitle：写入日历的主标题
 *locationStr：写入日历的副标题
 *startData：事件开始时间
 *endDate：事件结束时间
 *isReminder：是否写入提醒事项
 */
- (void)saveEventStartDate:(NSDate*)startData endDate:(NSDate*)endDate alarm:(float)alarm eventTitle:(NSString*)eventTitle location:(NSString*)location isReminder:(BOOL)isReminder successful:(CompletionBlock)successful failure:(CompletionBlock)failure;


@end
