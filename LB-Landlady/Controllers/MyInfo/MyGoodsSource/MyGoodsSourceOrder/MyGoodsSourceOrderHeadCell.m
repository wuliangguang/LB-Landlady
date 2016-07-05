//
//  MyGoodsSourceOrderHeadCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceOrderHeadCell.h"

@interface MyGoodsSourceOrderHeadCell ()

/** 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;

@end

@implementation MyGoodsSourceOrderHeadCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setOrderModel:(GoodSourceOrderModel *)orderModel {
    if (_orderModel != orderModel) {
        self.orderNumLabel.text = orderModel.order_id;
    }
}

@end
