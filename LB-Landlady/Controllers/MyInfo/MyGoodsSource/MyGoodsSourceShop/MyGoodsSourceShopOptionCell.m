//
//  MyGoodsSourceShopOptionCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceShopOptionCell.h"

@interface MyGoodsSourceShopOptionCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MyGoodsSourceShopOptionCell

- (void)awakeFromNib {
    // Initialization code
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = view;
    
    self.lineImageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIndustryModel:(IndustryModel *)industryModel {
    if (industryModel != _industryModel) {
        _industryModel = industryModel;
            self.nameLabel.text = [NSString stringWithFormat:@"%@", industryModel.industryName];
    }
    if (industryModel.check) {
        self.lineImageView.image = [UIImage imageNamed:@"red_line"];
        [self setSelected:YES animated:YES];
    } else {
        self.lineImageView.image = nil;
    }
}

@end
