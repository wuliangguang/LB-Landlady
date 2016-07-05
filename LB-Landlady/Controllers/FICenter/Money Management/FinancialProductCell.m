//
//  FinancialProductCell.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/9/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "FinancialProductCell.h"

@interface FinancialProductCell ()

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

@implementation FinancialProductCell

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

- (void)refreshUI {
//    self.rateLabel.text     = [NSString stringWithFormat:@"%f", self.model.rate];
//    self.nameLabel.text     = self.model.name;
//    self.deadlineLabel.text = [NSString stringWithFormat:@"%ld个月", self.model.deadline];
}

@end
