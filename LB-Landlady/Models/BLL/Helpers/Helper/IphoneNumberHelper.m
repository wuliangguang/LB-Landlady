//
//  IphoneNumberHelper.m
//  MeZoneB
//
//  Created by d2space on 15/6/1.
//  Copyright (c) 2015年 d2space. All rights reserved.
//

#import "IphoneNumberHelper.h"
#define NUM_ALL  @"0123456789"

@implementation IphoneNumberHelper
+ (BOOL)iphoneNumberInputRule:(NSString *)contentString InputString:(NSString *)inputString
{
    if ([contentString hasPrefix:@"0"])
    {
        return NO;
    }
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUM_ALL] invertedSet];
    NSString *filtered =[[inputString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [inputString isEqualToString:filtered];
    return basic;
}
@end
