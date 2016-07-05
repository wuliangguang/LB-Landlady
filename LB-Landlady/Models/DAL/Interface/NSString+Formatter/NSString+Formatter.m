//
//  NSString+Formatter.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/9/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "NSString+Formatter.h"

@implementation NSString (Formatter)

- (NSString *)formatPrice {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *str1 = [formatter stringFromNumber:[NSNumber numberWithFloat:[self floatValue]]];
    // NSLog(@"%@", str1); // 1,234,567.125
    
    // 整数部分
    NSRange range = [str1 rangeOfString:@"."];
    NSString *str_1 = range.location == NSNotFound ? str1 : [str1 substringToIndex:range.location];
    
    // 小数部分
    range = [self rangeOfString:@"."];
    NSString *str_2 = nil;
    if (range.location == NSNotFound) {
        str_2 = @".00";
    } else {
        str_2 = [self substringFromIndex:range.location];
        if (str_2.length == 1) {
            str_2 = @".00";
        } else if (str_2.length == 2) {
            str_2 = [NSString stringWithFormat:@"%@0", str_2];
        } else {
            str_2 = [str_2 substringToIndex:3];
        }
    }
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", str_1, str_2]);
    return [NSString stringWithFormat:@"%@%@", str_1, str_2];
}
- (NSString *)formatPriceTwo {
    float flo= [self floatValue]/100;
    NSString *str = [NSString stringWithFormat:@"%.2f",flo];
    if ([str isEqualToString:@"0.00"]){
    str = @"0";
    }
    return str;
}
@end
