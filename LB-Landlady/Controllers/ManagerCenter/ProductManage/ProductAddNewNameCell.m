//
//  ProductAddNewNameCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductAddNewNameCell.h"
#import "UITableViewCell+ZZAddLine.h"
@interface ProductAddNewNameCell()<UITextFieldDelegate>

@end
@implementation ProductAddNewNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showCustomLine = YES;
    self.productNameTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.blcok) {
        self.blcok(textField.text);
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
@end
