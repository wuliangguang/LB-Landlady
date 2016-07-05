//
//  TopCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/3.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

- (void)awakeFromNib {
    // Initialization code
    self.searchTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(5, 2, 20, 20)];
    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.searchTF.leftView.frame];

    imageView.image = [UIImage imageNamed: @"search"];
    [self.searchTF.leftView addSubview:imageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
