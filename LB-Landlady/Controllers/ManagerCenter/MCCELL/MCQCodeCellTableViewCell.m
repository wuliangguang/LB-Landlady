//
//  MCQCodeCellTableViewCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MCQCodeCellTableViewCell.h"
#import "MyBusinessInfoModel.h"

@implementation MCQCodeCellTableViewCell

- (void)awakeFromNib {
  
}
/**
 *  点击二维码的Block
 */
- (IBAction)QCodeBtnClick:(id)sender {
    self.QCodeBtnClickBlock();
}
/**
 *  点击查看店铺详情的Block
 */
- (IBAction)checkStoreDetailBtnClick:(id)sender {
    self.CheckStoreDetailBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMerchantItem:(MerchantListItemModel *)merchantItem {
    if (_merchantItem != merchantItem) {
        _merchantItem = merchantItem;
        NSLog(@"-------------------------merchantItem.business_name:%@",merchantItem.businessName);
        self.StoreNameLab.text = merchantItem.businessName;
        self.StoreAddressLab.text = merchantItem.address;

    }
}

@end
