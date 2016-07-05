//
//  GoodSourceDetailProductModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodSourceDetailProductModel : NSObject

@property (nonatomic, copy) NSString *detail;
@property (nonatomic) NSInteger industry_id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *business_id;
@property (nonatomic, copy) NSString *product_source_id;
@property (nonatomic, copy) NSString *product_source_title;

@end
