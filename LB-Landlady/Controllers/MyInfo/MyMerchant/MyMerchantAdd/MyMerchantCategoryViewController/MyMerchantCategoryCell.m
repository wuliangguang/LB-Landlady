//
//  MyMerchantCategoryCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantCategoryCell.h"

@interface MyMerchantCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@end

@implementation MyMerchantCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler(self.model);
    }
}

- (void)setModel:(IndustryModel *)model {
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.industryName]; // model.parant_name;
    [self.checkButton setImage:model.isCheck ? [UIImage imageNamed:@"my_merchant_check"] : [UIImage imageNamed:@"my_merchant_not_check.png"] forState:UIControlStateNormal];
}

@end
