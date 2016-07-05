//
//  ProductImageCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductImageCell.h"
#import "UITableViewCell+ZZAddLine.h"
@implementation ProductImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showCustomLine = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)productImageButtonClock:(id)sender {
    if (self.block) {
        self.block((UIButton *)sender);
    }
}
@end
