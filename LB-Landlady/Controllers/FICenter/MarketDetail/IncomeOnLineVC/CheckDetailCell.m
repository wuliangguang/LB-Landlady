//
//  CheckDetailCell.m
//  MeZoneB_Bate
//
//  Created by 喻晓彬 on 15/10/28.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "CheckDetailCell.h"

@implementation CheckDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)showIncomeDetailWithModel:(MM_IncomeModel *)model{
    self.cardNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",model.order_id];
    self.timeLabel.text = model.datetime;
    self.maneyLabel.text = model.price;
}
- (void)showCellWirhModel:(CheckDetailModel *)model {
        if (model.banknum.length >9) {
            NSString *str1 = [model.banknum substringFromIndex:model.banknum.length -4];
            self.cardNumberLabel.text = [NSString stringWithFormat:@"转出到卡尾号%@",str1];
        }
//    self.cardNumberLabel.text = [NSString stringWithFormat:@"转出到卡号%@",model.banknum];
    
    
    self.timeLabel.text = model.createTime;
    
    NSString *changeStr = [NSString stringWithFormat:@"-%d",[model.amount intValue]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"-%.2f",[model.amount floatValue]]];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:22]
                range:NSMakeRange(0, [changeStr length])];
    self.maneyLabel.attributedText = str;
    
}

@end
