//
//  TodayIncomeCCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "TodayIncomeCCell.h"
#import "NSString+Formatter.h"

@implementation TodayIncomeCCell

- (void)setIncome:(IncomeDataModel *)income {
    if (_income != income) {
        _income = income;
        if (income.totalAmt) {
            self.incomeLabel.text = income.totalAmt.formatPriceTwo;
        } else {
            self.incomeLabel.text = @"0";
        }
    }
}

@end
