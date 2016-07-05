//
//  ProductInventoryCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductInventoryCell.h"
#import "UITableViewCell+ZZAddLine.h"
@implementation ProductInventoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showCustomLine = YES;
    self.numberTextField.delegate = self;
    self.UnitTextField.delegate = self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(self.numberTextField.text,self.UnitTextField.text);
    }
}
@end
