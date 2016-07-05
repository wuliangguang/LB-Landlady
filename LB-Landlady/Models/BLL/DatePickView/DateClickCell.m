//
//  DateClickCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/14.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "DateClickCell.h"

@implementation DateClickCell

- (void)awakeFromNib {
    // Initialization code
    _width.constant = 0.5;
}
-(void)setIsRed:(BOOL)isRed
{
    _isRed = isRed;
    if (_isRed) {
        self.contentLab.textColor = [UIColor redColor];
    }else
    {
        self.contentLab.textColor =[UIColor blackColor];// LD_COLOR_ELEVEN;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
