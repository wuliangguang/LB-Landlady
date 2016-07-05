//
//  ProductPoolModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/2/23.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductPoolModel : NSObject

@property(nonatomic,strong)NSString * icon;/**<产品图片*/

@property(nonatomic,strong)NSString * industry_name;

@property(nonatomic,strong)NSString * pool_create_time;

@property(nonatomic,strong)NSString * product_pool_name;/**<产品名称*/

@property(nonatomic,strong)NSString * product_pool_id;/**<产品ID*/

@property(nonatomic,strong)NSString * end_date;/**<创建日期*/

@property(nonatomic,strong)NSString * price;/**<价格*/

@property(nonatomic,strong)NSString * unit;/**<单位*/

@property(nonatomic,assign)BOOL status;/**<是否下架*/

//@property(nonatomic,strong)NSString * product_type;/**<产品类型*/
@end
