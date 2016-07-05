//
//  RouteInfo.h
//  RouteInfoDemo
//
//  Created by d2space on 14-12-30.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ROUTE_MAC_ADD     @"Route-Mac-Address"    //路由器mac地址
#define ROUTE_IP_ADD      @"Route-IP-Address"     //路由器ip地址
#define ROUTE_NAME        @"Route-Name"           //路由器名称

#define IPHONE_NAME       @"Iphone-Name"          //手机用户名
#define IPHONE_IP_ADD     @"Iphone-IP-Address"    //手机ip地址

#define BROAD_CAST_IP_ADD @"broadcast-IP-Address" //广播地址

#define NET_MASK          @"netmask"              //子网掩码地址

#define INTERFACE_ADD     @"interface"            //端口地址


@interface RouteInfo : NSObject

+ (NSMutableDictionary *) getConnectionDeviceInfo;

//外网的地址
+ (void)getWANIPAddressWithCompletion:(void(^)(NSString *IPAddress))completion;
@end
