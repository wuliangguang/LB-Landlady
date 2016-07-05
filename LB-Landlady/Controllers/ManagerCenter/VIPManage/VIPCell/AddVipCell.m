//
//  AddVipCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "AddVipCell.h"

@implementation AddVipCell

- (void)awakeFromNib {
    _rejectBtn.layer.cornerRadius = 3;
    _rejectBtn.clipsToBounds = YES;
    _rejectBtn.layer.borderWidth = 1;
    _rejectBtn.layer.borderColor = LD_COLOR_TWELVE.CGColor;
    
    _OKbtn.clipsToBounds = YES;
    _OKbtn.layer.cornerRadius = 3;
    _OKbtn.layer.borderColor = LD_COLOR_ONE.CGColor;
    _OKbtn.layer.borderWidth = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------ButtonClick------
- (IBAction)rejectBtnClick:(id)sender {
    if (_cellBlock) {
        _cellBlock (0,_associationId);
    }
}


- (IBAction)OKBtnClick:(id)sender {
    if (_cellBlock) {
        _cellBlock (2,_associationId);
    }
}




@end
