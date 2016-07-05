//
//  MyMessageDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageDataModel.h"

@implementation MyMessageDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"message" : [MyMessageModel class]};
}

@end
