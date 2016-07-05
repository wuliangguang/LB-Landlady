//
//  OurStoreModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/2/22.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OurStoreModel : NSObject

@property(nonatomic,strong)NSString * icon;/**<产品图片*/

@property(nonatomic,strong)NSString * industry_name;

//@property(nonatomic,assign)BOOL is_onsale;/**<是否在售*/

@property(nonatomic,strong)NSString * product_id;/**<产品id*/

@property(nonatomic,strong)NSString * product_name;/**<产品名称*/

@property(nonatomic,strong)NSNumber * special_type;/**<特殊类型*/

@property(nonatomic,strong)NSString * start_date;/**<创建日期*/

@property(nonatomic,strong)NSString * price;/**<价格*/

@property(nonatomic,strong)NSString * unit;/**<单位*/

//@property(nonatomic,strong)NSString * type;/**<*/

@property(nonatomic,strong)NSString * product_type;/**<产品类型*/

@end
