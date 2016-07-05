//
//  ZZComminLimit.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZCommonLimit.h"

@implementation ZZCommonLimit

+ (void)phoneLimit:(UITextField *)textField {
    [self wordCountLimit:textField num:11];
}

+ (void)nameLimit:(UITextField *)textField {
    [self wordCountLimit:textField num:6];
}

+ (void)nickNameLimit:(UITextField *)textField {
    [self wordCountLimit:textField num:10];
}

+ (void)passwordLimit:(UITextField *)textField {
    [self wordCountLimit:textField num:18];
}

+ (void)wordCountLimit:(id)view num:(NSInteger)num {
    [view setValue:[NSNumber numberWithInteger:num] forKey:@"limit"];
}

@end
