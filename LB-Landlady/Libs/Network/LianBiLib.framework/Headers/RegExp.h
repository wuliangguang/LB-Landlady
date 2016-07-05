//
//  RegExp.h
//  MeZoneC
//
//  Created by d2space on 14-5-20.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegExp : NSObject
//邮箱
+(BOOL)validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
