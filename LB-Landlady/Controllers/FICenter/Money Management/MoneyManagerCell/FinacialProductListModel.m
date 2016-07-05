//
//  FinacialProductListModel.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/16.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FinacialProductListModel.h"

@implementation FinacialProductListModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"descriptiontext":@"description"
             };
}
@end
