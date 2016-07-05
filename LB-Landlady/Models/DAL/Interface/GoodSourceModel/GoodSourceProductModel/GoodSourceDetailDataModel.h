//
//  GoodSourceDetailDataModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodSourceDetailProductModel.h"
#import "GoodSourceDetailBusinessInfoModel.h"
#import "ProductPriceItem.h"

@interface GoodSourceDetailDataModel : NSObject

@property (nonatomic) GoodSourceDetailProductModel *productsrouce;
@property (nonatomic) GoodSourceDetailBusinessInfoModel *businessinfo;
@property (nonatomic) NSArray<ProductPriceItem *> *priceItemArray;

- (NSString *)priceInfo;

/**
 *  根据产品数量返回与之匹配的ProductPriceItem对象
 */
- (ProductPriceItem *)priceItemForProductVolume:(NSInteger)volume;

/**
 *  选中的项
 */
- (ProductPriceItem *)checkedPriceItem;

@end
