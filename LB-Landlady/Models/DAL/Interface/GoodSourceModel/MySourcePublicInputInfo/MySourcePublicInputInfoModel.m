//
//  MySourcePublicInputInfoModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublicInputInfoModel.h"

@implementation MySourcePublicInputInfoModel

- (NSString *)priceUnit {
    return @"元";
}

- (NSString *)numString {
    return [NSString stringWithFormat:@"%@-%@", self.num, self.unit];
}

- (NSString *)priceString {
    return [NSString stringWithFormat:@"%@-元", self.price];
}

- (NSString *)verifyInputData {
    if (self.num.length <= 0) {
        return @"请输入数量";
    }
    if (self.unit.length <= 0) {
        return @"请输入单位";
    }
    if (self.price.length <= 0) {
        return @"请输入价格";
    }
    return nil;
}

@end
