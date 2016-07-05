//
//  GoodSourceOrderModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodSourceOrderModel : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic) BOOL is_pay;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic) NSInteger amount;
@property (nonatomic, copy) NSString *business_id;
@property (nonatomic, copy) NSString *product_source_id;
@property (nonatomic, copy) NSString *product_source_title;
@property (nonatomic) NSInteger industry_id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *vendorPhone;
@property (nonatomic, copy) NSString *business_name;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic) NSInteger num;
@property (nonatomic) double price;
@property (nonatomic, copy) NSString *address;
@end
