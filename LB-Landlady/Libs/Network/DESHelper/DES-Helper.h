//
//  DES-Helper.h
//  DES-Demo
//
//  Created by d2space on 15/10/26.
//  Copyright © 2015年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/******字符串转base64（包括DES加密）******/
#define ENCODE( text,key,iv )          [DES_Helper base64StringFromText:text WithKey:key WithIV:iv]

/******base64（通过DES解密）转字符串******/
#define DECODE( base64,key,iv )        [DES_Helper textFromBase64String:base64 WithKey:key WithIV:iv]


@interface DES_Helper : NSObject

/************************************************************
 函数名称 :+ (NSString *)base64StringFromText:(NSString *)text WithKey:(NSString *)key WithIV:(NSString *)iv
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)base64：文本  (NSString *)key：key字符串 (NSString *)iv：optional initialization vector
 输出参数 : N/A
 返回参数 : (NSString *)base64格式字符串
 备注信息 :
 **********************************************************/
+ (NSString *)base64StringFromText:(NSString *)text WithKey:(NSString *)key WithIV:(NSString *)iv;

/************************************************************
 函数名称 :+ (NSString *)textFromBase64String:(NSString *)base64 WithKey:(NSString *)key WithIV:(NSString *)iv
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64：加密文本  (NSString *)key：key字符串 (NSString *)iv：optional initialization vector
 输出参数 : N/A
 返回参数 : (NSString *)文本
 备注信息 :
 **********************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64 WithKey:(NSString *)key WithIV:(NSString *)iv;

@end
