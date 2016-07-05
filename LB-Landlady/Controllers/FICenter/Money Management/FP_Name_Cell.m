//
//  FP_Name_Cell.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/8.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FP_Name_Cell.h"

@interface FP_Name_Cell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

@implementation FP_Name_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setModel:(FinancialProductModel *)model {
//    if (_model != model) {
//        _model = model;
//        [self refreshUI];
//    }
//}

//- (void)refreshUI {
//    self.nameLabel.text     = self.model.name;
//    self.rateLabel.text     = [NSString stringWithFormat:@"%.4f%@", self.model.rate,@"%"];
//    self.rateLabel.attributedText = [GLLabel annualRateStr:self.rateLabel.text];
//    self.deadlineLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.deadline];
//}

@end
