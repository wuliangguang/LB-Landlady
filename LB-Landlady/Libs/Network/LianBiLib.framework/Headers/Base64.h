//
//  Base64.h
//  MeZoneB
//
//  Created by d2space on 14-8-11.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base64Define.h"

@interface Base64 : NSObject

+(NSData *)encodeData:(NSData *)data;
+(NSData *)decodeData:(NSData *)data;
+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;
+(NSString *)stringByEncodingData:(NSData *)data;
+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;
+(NSData *)decodeString:(NSString *)string;
+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;
+(NSData *)webSafeDecodeData:(NSData *)data;
+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;
+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;
+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;
+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;
+(NSData *)webSafeDecodeString:(NSString *)string;

@end
