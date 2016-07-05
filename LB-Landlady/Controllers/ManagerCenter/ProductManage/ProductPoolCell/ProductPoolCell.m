//
//  ProductPoolCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductPoolCell.h"

@implementation ProductPoolCell

- (void)awakeFromNib {
    // Initialization code
//    self.pstatusBtn.layer.borderColor = 
}
- (IBAction)btnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (self.productionPoolBtnClickBlock) {
        self.productionPoolBtnClickBlock(btn.tag);
    }
}

-(void)setType:(PRODUCTION_TYPE)type
{
    _type = type;
    switch (type) {
        case PRODUCTION_TYPE_HUO:
            self.pStatusImageview.image = [UIImage imageNamed: @"huo"];
            break;
        case PRODUCTION_TYPE_SHANG:
            self.pStatusImageview.image = [UIImage imageNamed: @"shang"];
            break;
           case PRODUCTION_TYPE_TUAN:
            self.pStatusImageview.image = [UIImage imageNamed: @"tuan"];
            break;
        case PRODUCTION_TYPE_YOU:
            self.pStatusImageview.image = [UIImage imageNamed: @"you"];
            break;
        case PRODUCTION_TYPE_ZHU:
            self.pStatusImageview.image = [UIImage imageNamed: @"zhu"];
            break;
        default:
            self.pStatusImageview.hidden =YES;
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
