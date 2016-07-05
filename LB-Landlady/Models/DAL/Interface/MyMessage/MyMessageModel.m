//
//  MyMessage.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageModel.h"

@implementation MyMessageModel

- (NSString *)messageTypeStr {
    switch (MyMessageTypeOrder) {
        case MyMessageTypeSystem:
            return @"系统";
        case MyMessageTypeOrder:
            return @"订单";
        case MyMessageTypeCustom:
            return @"订制";
        default:
            break;
    }
}

@end
