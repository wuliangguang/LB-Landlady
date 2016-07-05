//
//  MySourcePublicInputInfoModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 3/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySourcePublicInputInfoModel : NSObject

/**
 * 数量
 */
@property (nonatomic, copy) NSString *num;

/**
 * 数量单位
 */
@property (nonatomic, copy) NSString *unit;

/**
 * 价格
 */
@property (nonatomic, copy) NSString *price;

/**
 * 价格单位-元
 */
@property (nonatomic, copy) NSString *priceUnit;

- (NSString *)verifyInputData;
- (NSString *)numString;
- (NSString *)priceString;

@end