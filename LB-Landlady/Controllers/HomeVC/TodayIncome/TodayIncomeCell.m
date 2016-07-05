//
//  TodayIncomeCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "TodayIncomeCell.h"
#import "UITableViewCell+ZZAddLine.h"
@implementation TodayIncomeCell

- (void)awakeFromNib {
    self.showCustomLine = YES;
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}
- (void)updateWithString:(NSString *)str{
    if ([str isEqualToString:@"0.00"]) {
        str = @"0";
    }
    self.moneyLabel.text = str;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
