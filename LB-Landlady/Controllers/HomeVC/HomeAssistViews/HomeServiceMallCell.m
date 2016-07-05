//
//  HomeServiceMallCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomeServiceMallCell.h"
#import "UIImageView+WebCache.h"

@interface HomeServiceMallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation HomeServiceMallCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ServermalllistModel *)model {
    if (_model != model) {
        _model = model;
        self.nameLabel.text = _model.mall_name;
        self.detailLabel.text = _model.detail;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.icon] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
    }
}

@end
