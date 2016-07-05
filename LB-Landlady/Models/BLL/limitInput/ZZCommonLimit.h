//
//  ZZComminLimit.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  手机号字数限制，人名字数限制，程序中用的比较多，在此简单封装
 */
@interface ZZCommonLimit : NSObject

/**
 *  限制最多11位
 */
+ (void)phoneLimit:(UITextField *)textField;

/**
 *  限制小于6个字符
 */
+ (void)nameLimit:(UITextField *)textField;

/**
 *  昵称小于10个字符
 */
+ (void)nickNameLimit:(UITextField *)textField;

/**
 *  限制小于18个字符
 */
+ (void)passwordLimit:(UITextField *)textField;

/**
 *  限制输入字数
 */
+ (void)wordCountLimit:(id)view num:(NSInteger)num;

@end
