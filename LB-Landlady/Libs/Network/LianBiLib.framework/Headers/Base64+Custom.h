//
//  Base64+Custom.h
//  MeZoneB
//
//  Created by d2space on 14-8-11.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import "Base64.h"

@interface Base64 (Custom)

+ (NSString*)stringEncodeBase64String:(NSString*)input;

+ (NSString*)stringDecodeBase64String:(NSString*)input;

+ (NSString*)dataEncodeBase64ToString:(NSData*)data;

+ (NSString*)dataDecodeBase64ToString:(NSData*)data;

+ (NSData*)dataEncodeBase64ToData:(NSData*)data;

+ (NSData*)dataDecodeBase64ToData:(NSData*)data;

@end
