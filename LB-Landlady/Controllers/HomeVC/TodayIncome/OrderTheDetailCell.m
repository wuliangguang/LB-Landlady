//
//  OrderTheDetailCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OrderTheDetailCell.h"
#import "UITableViewCell+ZZAddLine.h"

@implementation OrderTheDetailCell

- (void)awakeFromNib {
    self.showCustomLine = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)orderDetailButtonClock:(id)sender {
    self.string = @"orderDetailButtonClock";
    if(self.block){
        self.block(self.string);
    }
}

- (IBAction)incomeDetailButtonClock:(id)sender {
    self.string = @"incomeDetailButtonClock";
    if(self.block){
        self.block(self.string);
    }
}
@end
