//
//  Momomon_manager_header_Cell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/19.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "Momomon_manager_header_Cell.h"

@implementation Momomon_manager_header_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIncome:(IncomeDataModel *)income {
    if (_income != income) {
        _income = income;
        if (income.totalAmt) {
            self.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",[income.totalAmt floatValue]/100];
        }else
        {
            self.MM_moneyLab.text = @"0";
        }
        
    }
}

@end
