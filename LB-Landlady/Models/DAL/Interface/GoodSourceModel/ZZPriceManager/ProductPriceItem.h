//
//  ZZPriceItem.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductPriceItem : NSObject  // 1-斤 100-元

/**
 *  产品量，比如：1
 */
@property (nonatomic) double productVolume;

/**
 *  产品单位，比如：斤
 */
@property (nonatomic, copy) NSString *productUnit;

/**
 *  钱的数量，比如：100
 */
@property (nonatomic) double priceVolume;

/**
 *  钱的单位，比如：元
 */
@property (nonatomic, copy) NSString *priceUnit;

@property (nonatomic) BOOL check;

+ (NSArray<ProductPriceItem *> *)priceItemArrayWithPrice:(NSString *)price unit:(NSString *)unit;

/**
 *  1/斤
 */
- (NSString *)volumeStr;

/**
 *  ￥100/元
 */
- (NSString *)priceStr;
- (NSAttributedString *)attributePriceStr;

- (double)totalPrice; // 总价
- (NSString *)totalPriceStr; // 总价（字符串表示）

@end
