//
//  MerchantListDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/27/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MerchantListDataModel.h"

@implementation MerchantListDataModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"modelList" : [MerchantListItemModel class]};
}

@end
