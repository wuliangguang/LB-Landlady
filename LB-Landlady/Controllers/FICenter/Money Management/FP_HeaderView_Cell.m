//
//  FP_HeaderView_Cell.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/9.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FP_HeaderView_Cell.h"

@interface FP_HeaderView_Cell ()

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalprofitLabel;

@end

@implementation FP_HeaderView_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

//- (void)setModel:(TotalResult *)model {
//    if (_model != model) {
//        _model = model;
//        [self refreshUI];
//    }
//}

//- (void)refreshUI {
//    _totalLabel.text      = [NSString stringWithFormat:@"%.2f", self.model.total];
//    _totalprofitLabel.text = [NSString stringWithFormat:@"%.2f", self.model.totalprofit];
//}

@end
