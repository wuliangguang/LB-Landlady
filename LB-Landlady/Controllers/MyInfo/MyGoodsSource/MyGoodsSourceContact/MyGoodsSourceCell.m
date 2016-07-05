//
//  MyGoodsSourceCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceCell.h"
#import "UIImageView+WebCache.h"

@interface MyGoodsSourceCell ()

@property (strong, nonatomic) IBOutlet UIImageView *goodSourceImage;/**<货源图片*/
@property (strong, nonatomic) IBOutlet UILabel *goodsSourceContactLab;/**<货源联系人姓名*/
@property (strong, nonatomic) IBOutlet UILabel *goodsSourceContex;/**<货源内容*/
@property (strong, nonatomic) IBOutlet UILabel *goosSourceTelLab;/**<货源联系电话*/
@end

@implementation MyGoodsSourceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDataModel:(GoodSourceModel *)dataModel {
    if (_dataModel != dataModel) {
        _dataModel = dataModel;
        [self.goodSourceImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.contacts_img] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
        self.goodsSourceContactLab.text = _dataModel.contacts_name;
        self.goodsSourceContex.text     = _dataModel.contacts_srouceDetail;
        self.goosSourceTelLab.text      = _dataModel.contacts_phone;
    }
}

@end
