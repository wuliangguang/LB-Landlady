//
//  OrderListDetailModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/3/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListDetailModel : NSObject

@property(nonatomic,strong) NSString * icon;//
@property(nonatomic,strong) NSString * createTime;//
@property(nonatomic,strong) NSString * user_name;//
@property(nonatomic,assign) NSInteger num;//
@property(nonatomic,strong) NSString * phone;//
@property(nonatomic,strong) NSString * price;//
@property(nonatomic,strong) NSString * address;//
@property(nonatomic,assign) NSInteger  status;//
@property(nonatomic,strong) NSString *order_id;//
@property(nonatomic,strong) NSString * productName;//
@property(nonatomic,assign)float amount;//

//二维码字符串 @d2space
@property (nonatomic ,strong) NSString * urlCode;

@end
