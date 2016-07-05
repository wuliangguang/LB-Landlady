//
//  GoodSourceOrderDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "GoodSourceOrderDataModel.h"

@implementation GoodSourceOrderDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"productSourceList" : [GoodSourceOrderModel class]};
}

@end
