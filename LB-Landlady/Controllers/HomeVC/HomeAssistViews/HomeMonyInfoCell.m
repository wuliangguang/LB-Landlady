//
//  HomeMonyInfoCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomeMonyInfoCell.h"
#import "NSString+Formatter.h"
#import "UITableViewCell+ZZAddLine.h"
@interface HomeMonyInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@end

@implementation HomeMonyInfoCell

- (void)awakeFromNib {
    self.showCustomLine = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 查看详情
- (IBAction)gotoDetail:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

- (void)setIncome:(IncomeDataModel *)income {
    if (_income != income) {
        _income = income;
        if (income.totalAmt.length <= 0) {
            self.moneyLabel.text = @"0";
        } else {
            self.moneyLabel.text = income.totalAmt.formatPriceTwo;
        }
    }
}

@end
