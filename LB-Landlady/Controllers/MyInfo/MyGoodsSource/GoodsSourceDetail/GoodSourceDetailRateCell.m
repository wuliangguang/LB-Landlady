//
//  GoodSourceDetailRateCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "GoodSourceDetailRateCell.h"

@interface GoodSourceDetailRateCell ()

/**
 *  勾选/取消选中圆形按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation GoodSourceDetailRateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItemModel:(ProductPriceItem *)itemModel {
    if (_itemModel != itemModel) {
        _itemModel = itemModel;
        self.countLabel.text = [itemModel volumeStr];
        self.priceLabel.attributedText = [itemModel attributePriceStr];
    }
    if (itemModel.check == YES) {
        [self.checkButton setImage:[UIImage imageNamed: @"my_merchant_check"] forState:UIControlStateNormal];
    } else {
        [self.checkButton setImage:[UIImage imageNamed: @"my_merchant_not_check"] forState:UIControlStateNormal];
    }
}

@end
