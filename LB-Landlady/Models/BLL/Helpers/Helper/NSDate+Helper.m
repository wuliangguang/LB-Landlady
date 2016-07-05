//
//  NSDate+Helper.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

- (NSString *)toString {
    return [self toStringWithFormat:@"yyyyMMddHHmmss"];
}

- (NSString *)toStringWithFormat:(NSString *)aFormat {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:aFormat];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSDate *)addDays:(NSInteger)days {
    return [[NSDate date] dateByAddingTimeInterval:days*24*60*60];
}

@end
