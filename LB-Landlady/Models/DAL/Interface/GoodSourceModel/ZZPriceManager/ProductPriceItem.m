//
//  ZZPriceItem.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ProductPriceItem.h"
#import "GLLabel.h"

@implementation ProductPriceItem

+ (NSArray<ProductPriceItem *> *)priceItemArrayWithPrice:(NSString *)price unit:(NSString *)unit {
    if (price.length <= 0 || unit.length <= 0) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *priceArray = [NSMutableArray arrayWithArray:[price componentsSeparatedByString:@","]];
    [priceArray removeObject:@""];
    NSMutableArray *unitArray = [NSMutableArray arrayWithArray:[unit componentsSeparatedByString:@","]];
    [unitArray removeObject:@""];
    if (priceArray.count <= 0 || priceArray.count != unitArray.count) {
        return nil;
    }
    for (NSInteger i = 0; i < priceArray.count; i++) {
        NSArray *itemArray      = [priceArray[i] componentsSeparatedByString:@"-"];
        ProductPriceItem *priceItem  = [[ProductPriceItem alloc] init];
        priceItem.priceVolume   = [itemArray[0] doubleValue];// 钱的数量
        priceItem.priceUnit     = itemArray[1]; // 价格单位
        itemArray               = [unitArray[i] componentsSeparatedByString:@"-"];
        priceItem.productVolume = [itemArray[0] doubleValue];
        priceItem.productUnit   = itemArray[1];
        [array addObject:priceItem];
    }
    return array;
}

- (NSString *)volumeStr {
    return [NSString stringWithFormat:@"%ld/%@", (NSInteger)self.productVolume, self.productUnit];
    return nil;
}

- (NSString *)priceStr {
    return [NSString stringWithFormat:@"￥%.2lf/%@", self.priceVolume, self.priceUnit];
}

- (NSAttributedString *)attributePriceStr {
    return [GLLabel attributeStrWithBigStr:[NSString stringWithFormat:@"￥%.2lf", self.priceVolume] smallStr:[NSString stringWithFormat:@"/%@", self.priceUnit]];
}

- (double)totalPrice {
    // 单价 * 数量
    return self.priceVolume * self.productVolume;
}

- (NSString *)totalPriceStr {
    return [NSString stringWithFormat:@"￥%.2lf", [self totalPrice]];
}

@end
