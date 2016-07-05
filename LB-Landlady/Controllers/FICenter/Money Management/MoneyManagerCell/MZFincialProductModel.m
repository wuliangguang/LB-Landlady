//
//  MZFincialProductModel.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/16.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "MZFincialProductModel.h"

@implementation MZFincialProductModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"result" : NSStringFromClass([FinacialProductListModel class])};
}

@end
