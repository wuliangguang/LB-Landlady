//
//  NSArray+Hepler.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/28.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "NSArray+Hepler.h"

@implementation NSArray (Hepler)
- (NSArray *)sortBackArr:(NSArray *)arr {
    if (arr == nil) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
    for (int i = 0; i < array.count; i ++) {
        NSString *str = (NSString *)array[i];
        if ([str isEqualToString:@""] || [self IsChinese:str]) {
            NSLog(@"====%d",i);
            [array removeObjectAtIndex:i];
            i = i -1;
        }
    }
    return array;
}
-(BOOL)IsChinese:(NSString *)str {
    for(NSInteger i=0; i < str.length;i ++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}

@end
