//
//  GoodSourceDetailDataModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "GoodSourceDetailDataModel.h"

@implementation GoodSourceDetailDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"productsrouce" : [GoodSourceDetailProductModel class]};
}

- (NSString *)priceInfo {
    return nil;
}

- (ProductPriceItem *)priceItemForProductVolume:(NSInteger)volume {
    NSInteger targetVolume = 0;
    NSInteger tempVolume   = 0;
    ProductPriceItem *targetPriceItem = nil;
    for (ProductPriceItem *priceItem in self.priceItemArray) {
        if ((NSInteger)priceItem.productVolume <= volume) {
            tempVolume = (NSInteger)priceItem.productVolume;
            if (targetVolume < tempVolume) {
                tempVolume      = targetVolume;
                targetPriceItem = priceItem;
            }
        }
    }
    return targetPriceItem;
}

- (ProductPriceItem *)checkedPriceItem {
    for (ProductPriceItem *priceItem in self.priceItemArray) {
        if (priceItem.check == YES) {
            return priceItem;
        }
    }
    return nil;
}

@end
