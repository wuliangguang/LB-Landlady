//
//  FM_productList_cell.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/16.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FM_productList_cell.h"
#import "GLLabel.h"

@implementation FM_productList_cell

- (void)awakeFromNib {
    // Initialization code
    
}
-(void)setModel:(FinacialProductListModel *)model
{
    if (_model!=model) {
        _model = model;
        _nameLab.text = _model.name;
        _descriptionLab.text = _model.descriptiontext;
        _rateLab.text = [NSString stringWithFormat:@"≈%.4f%@",_model.rate,@"%"];
        self.rateLab.attributedText = [GLLabel annualRateStr:self.rateLab.text];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
