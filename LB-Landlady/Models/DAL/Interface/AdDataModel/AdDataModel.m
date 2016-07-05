//
//  AdDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/8/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "AdDataModel.h"

@implementation AdDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"advertList" : [AdModel class]};
}

@end
