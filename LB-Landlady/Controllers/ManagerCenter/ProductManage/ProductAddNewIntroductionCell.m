//
//  ProductAddNewIntroductionCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductAddNewIntroductionCell.h"
#import "UITableViewCell+ZZAddLine.h"
@implementation ProductAddNewIntroductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showCustomLine = YES;
    self.Intextview.placeholder = @"商品简介(30以内)";
    self.Intextview.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return NO;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.block) {
        self.block(textView.text);
    }
}
@end
