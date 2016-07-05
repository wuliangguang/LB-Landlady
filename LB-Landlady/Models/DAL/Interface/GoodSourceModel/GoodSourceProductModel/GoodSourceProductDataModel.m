//
//  GoodSourceProductDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "GoodSourceProductDataModel.h"

@implementation GoodSourceProductDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"productSourceList" : [GoodSourceProductModel class]};
}
@end
