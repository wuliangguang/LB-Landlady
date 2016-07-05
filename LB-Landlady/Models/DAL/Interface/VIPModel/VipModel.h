//
//  VipModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/21.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipModel : NSObject

@property(nonatomic,assign)NSInteger b_level_id;/**<会员卡编号*/
@property(nonatomic,strong)NSString * b_level_name;/**<会员等级名称*/
@property(nonatomic,assign)CGFloat b_discount;/**<折扣*/
@property(nonatomic,assign)BOOL status;
@property(nonatomic,assign)CGFloat price;/**<需要消费的钱*/
@property(nonatomic,strong)NSString * b_leve_detail;/**<会员详细*/
@end
