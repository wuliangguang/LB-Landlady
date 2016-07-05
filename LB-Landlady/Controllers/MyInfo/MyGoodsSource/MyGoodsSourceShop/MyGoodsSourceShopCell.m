//
//  MyGoodsSourceShopCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceShopCell.h"
#import "UIImageView+WebCache.h"

@interface MyGoodsSourceShopCell ()

/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/**
 *  商品图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation MyGoodsSourceShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductModel:(GoodSourceProductModel *)productModel {
    if (_productModel != productModel) {
        _productModel = productModel;
        self.titleLabel.text = productModel.product_source_title;
        self.priceLabel.text = [self getPriceUnit];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:productModel.image] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
    }
}

- (NSString *)getPriceUnit {
    if (_productModel.price.length <= 0) {
        return nil;
    }
    NSArray *priceArray  = [_productModel.price componentsSeparatedByString:@","];
    NSString *price      = priceArray[0];
    NSArray *priceArray2 = [price componentsSeparatedByString:@"-"];
    price                = [NSString stringWithFormat:@"%@%@", priceArray2[0], priceArray2[1]];
    NSArray *unitArray   = [_productModel.unit componentsSeparatedByString:@","];
    NSArray *unitArray2  = [unitArray[0] componentsSeparatedByString:@"-"];
    NSString *unit       = [unitArray2 lastObject];
    return [NSString stringWithFormat:@"%@/%@", price, unit];
}

@end
