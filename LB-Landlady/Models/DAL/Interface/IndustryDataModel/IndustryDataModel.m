//
//  IndustryDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/26/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "IndustryDataModel.h"

@implementation IndustryDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"modelList" : [IndustryModel class]
             };
}

@end
