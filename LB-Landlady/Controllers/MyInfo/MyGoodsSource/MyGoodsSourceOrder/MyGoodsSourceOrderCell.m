//
//  MyGoodsSourceOrderCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceOrderCell.h"
#import "UIImageView+WebCache.h"

@interface MyGoodsSourceOrderCell ()

/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** 数量 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

/** 总计金额 */
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation MyGoodsSourceOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setOrderModel:(GoodSourceOrderModel *)orderModel {
    if (_orderModel != orderModel) {
        _orderModel               = orderModel;
        self.nameLabel.text       = orderModel.product_source_title;
        self.countLabel.text      = [NSString stringWithFormat:@"x%ld", orderModel.num];
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f", orderModel.price];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:orderModel.image] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
    }
}

@end
