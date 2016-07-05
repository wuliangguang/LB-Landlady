//
//  StatusCode.m
//  MeZone
//
//  Created by d2space on 14-5-7.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import "StatusCode.h"

@implementation StatusCode

+(NSString *)statusChangeCN:(NSInteger)errorCode
{
    switch (errorCode)
    {
        case 4091:
            return @"在线订单不存在！";
            break;
        case 4061:
            return @"行业不存在！";
            break;
        default:
            return @"服务器发生未知错误，可以反馈给我们喔！";
            break;
    }
}

@end
