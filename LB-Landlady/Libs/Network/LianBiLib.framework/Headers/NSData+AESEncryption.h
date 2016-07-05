//
//  NSData+AESEncryption.h
//  
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 联璧电子科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENCRYPTION_AES128


/*********************************
 可配置AES加密类型，默认为AES128，若需要
 配置为AES256，在此前增加
 #define ENCRYPTION_AES256即可
 *********************************/

#ifdef ENCRYPTION_AES256
#define AES_KEY_SIZE        32
#define AES_BLOCK_SIZE      32
#elif defined ENCRYPTION_AES192
#define AES_KEY_SIZE        24
#define AES_BLOCK_SIZE      24
#else
#define AES_KEY_SIZE        16
#define AES_BLOCK_SIZE      16
#endif

@class NSString;


@interface NSData (AESEncryption)

- (NSData *)AESEncryptWithKey:(NSString *)key;   //加密
- (NSData *)AESDecryptWithKey:(NSString *)key;   //解密


@end
