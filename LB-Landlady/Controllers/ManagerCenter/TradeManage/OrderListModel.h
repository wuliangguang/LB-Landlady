//
//  OrderListModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/3/5.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject
@property(nonatomic,strong)NSString * order_id;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * price;
@property(nonatomic)NSString * address;
@property(nonatomic,assign)float amount;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic,strong)NSString * phone;
@property(nonatomic,strong)NSString * product_source_title;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString * unit;

@end
