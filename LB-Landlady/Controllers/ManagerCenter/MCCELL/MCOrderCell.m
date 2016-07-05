//
//  MCOrderCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MCOrderCell.h"
#import <UIImageView+WebCache.h>

@implementation MCOrderCell

- (void)awakeFromNib {
    // Initialization code
    self.topConstraint.constant = 0.5;
    self.bottomConstraint.constant = 0.5;
}
-(void)setModel:(OrderListDetailModel *)model
{
    _model = model;
    self.orderNumLab.text = model.order_id;
    self.stateLab.text = @"已完成";
    self.stateLab.backgroundColor = LD_COLOR_SIX;
    [self.orderImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
    self.orderNameLab.text = model.productName;
    if (model.price == NULL) {
        self.perPriceLab.text = [NSString stringWithFormat:@"￥%.2f",model.amount];
    }else
    {
        self.perPriceLab.text = [NSString stringWithFormat:@"￥%@",[[model.price componentsSeparatedByString:@"-"] firstObject]];
    }
    self.numLab.text = [NSString stringWithFormat:@"x%d",model.num];
    self.dateLab.text = model.createTime ;
    if (_model.price == NULL) {
        self.totalLab.text = [NSString stringWithFormat:@"￥%.2f",model.amount * model.num];
    }else
    {
        self.totalLab.text = [NSString stringWithFormat:@"￥%d", [[[model.price componentsSeparatedByString:@"-"] firstObject] integerValue] * model.num];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
