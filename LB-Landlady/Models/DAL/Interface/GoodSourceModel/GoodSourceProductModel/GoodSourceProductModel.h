//
//  GoodSourceProductModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodSourceProductModel : NSObject

/**
 *  商品名称
 */
@property (nonatomic, copy) NSString *product_source_title;

/**
 *  商品图标
 */
@property (nonatomic, copy) NSString *image;

/**
 *  价格
 */
@property (nonatomic, copy) NSString *price;

/**
 *  id号
 */
@property (nonatomic, copy) NSString *industry_id;

/**
 *  xxx份
 */
@property (nonatomic, copy) NSString *unit;

/**
 *  具体的产品id
 */
@property (nonatomic, copy) NSString *product_source_id;;

@end
