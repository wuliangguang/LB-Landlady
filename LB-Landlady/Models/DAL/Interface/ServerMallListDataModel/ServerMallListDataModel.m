//
//  ServerMallListDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ServerMallListDataModel.h"

@implementation ServerMallListDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"serverMallList" : [ServermalllistModel class]};
}
@end
