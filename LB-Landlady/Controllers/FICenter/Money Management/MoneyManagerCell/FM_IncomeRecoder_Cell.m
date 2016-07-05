//
//  FM_IncomeRecoder_Cell.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/9.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FM_IncomeRecoder_Cell.h"

@implementation FM_IncomeRecoder_Cell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(FM_detailModel *)model
{
    if (_model != model) {
        _model = model;
        _dateLab.text = _model.date;
        _amountLab.text = [NSString stringWithFormat:@"%.2f",_model.amount];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
