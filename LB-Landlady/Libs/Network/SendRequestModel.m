//
//  SendRequestModel.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/28.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "SendRequestModel.h"

@implementation SendRequestModel
+(NSString *)backStrFromeArr:(NSArray *)arr{
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
    for (NSInteger index = 0; index < array.count; index ++) {
        SendRequestModel *model = array[index];
        if ([model.detailStr isEqualToString:@""] || [model IsChinese:model.detailStr]) {
            NSLog(@"====%ld",index);
            [array removeObjectAtIndex:index];
            index = index -1;
        }
    }
    NSArray *backArr = [array sortedArrayUsingComparator:^NSComparisonResult(SendRequestModel *obj1, SendRequestModel *obj2) {
        NSString *name1 = obj1.name;
        NSString *name2 = obj2.name;
        return [name1 caseInsensitiveCompare:name2];
    }];
    NSMutableArray *arrA = [NSMutableArray array];
    for (NSInteger index = 0; index < backArr.count; index ++) {
        SendRequestModel *model = backArr[index];
        [arrA addObject:model.detailStr];
    }
    NSString *sign = @"";
    for (NSInteger index = 0; index < arrA.count; index ++) {
        sign = [sign stringByAppendingString:arrA[index]];
    }
    NSLog(@"-=-=-=-=---------sign:%@",[sign stringByAppendingString:s_key]);
    sign = [[sign stringByAppendingString:s_key] mdd5];
    
    return sign;
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
