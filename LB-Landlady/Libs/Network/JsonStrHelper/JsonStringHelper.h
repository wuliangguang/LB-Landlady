//
//  JsonStringHelper.h
//  MeZoneB_Bate
//
//  Created by d2space on 15/6/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonStringHelper : NSObject

//Json String 转换成 nsdiction
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//nsdiction 转换成 jsonString
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
