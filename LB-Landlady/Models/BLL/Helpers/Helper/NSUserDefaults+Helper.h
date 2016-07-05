//
//  NSUserDefaults+Helper.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Helper)

/** 纬度 */
@property (nonatomic, copy) NSString *latitude;

/** 径度 */
@property (nonatomic, copy) NSString *longitude;

/** 用户名 */
@property (nonatomic, copy) NSString *username;

/** 密码 */
@property (nonatomic, copy) NSString *password;

/* 是否第一次进入 */
@property (nonatomic) BOOL didAccess;

/**
 *  退出登录后清空相关信息
 */
- (void)clear;

@end
