//
//  VipAddModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/2/24.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipAddModel : NSObject
@property(nonatomic,strong)NSString * associator_address;/**<会员地址*/

@property(nonatomic,strong)NSString * associator_phone;/**<会员电话*/

@property(nonatomic,strong)NSString * associator_detail;/**<会员详细*/

@property(nonatomic,assign)BOOL status;/**<会员状态*/

@property(nonatomic,assign)NSInteger associator_level;/**<会员等级*/

@property(nonatomic,assign)NSInteger associator_id;/**<会员ID*/

@property(nonatomic,strong)NSString * associator_name;/**<会员名*/



@end
