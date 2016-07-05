//
//  MCManageCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MCManageCell.h"

@implementation MCManageCell

- (void)awakeFromNib {
    // Initialization code
    dispatch_async(dispatch_get_main_queue(), ^{
        _width.constant = (kScreenWidth - 30) / 2.0;
        NSLog(@"%f",_width.constant);
    });
}
- (IBAction)productManageBtnClick:(id)sender {
    self.productBtnBlock();
}
- (IBAction)waiterManageBtnClick:(id)sender {
    self.waiterBtnBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
