//
//  MyMerchantListCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantListCell.h"

@interface MyMerchantListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MyMerchantListCell

- (void)setModel:(MerchantListItemModel *)model {
    if (_model != model) {
        _model                   = model;
        self.nameLabel.text      = _model.businessName;
        self.phoneLabel.text     = _model.phone;
        self.addressLabel.text   = _model.address;
    }
    self.iconImageView.image = _model.check ? [UIImage imageNamed:@"my_merchant_check"] : [UIImage imageNamed:@"my_merchant_not_check"];
}

@end
