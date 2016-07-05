//
//  ProvinceCell.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/29.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProvinceCell.h"
#import "UITableViewCell+ZZAddLine.h"
@implementation ProvinceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showCustomLine = YES;
}
- (void)updateModel:(ProinceModel *)model{
    self.provinceLabel.text = model.province;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
