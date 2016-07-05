//
//  MCQCodeCellTableViewCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantListItemModel.h"

@interface MCQCodeCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *StoreNameLab;
@property (strong, nonatomic) IBOutlet UILabel *StoreAddressLab;

@property(nonatomic,copy)void(^QCodeBtnClickBlock)();
@property(nonatomic,copy)void(^CheckStoreDetailBlock)();

@property (nonatomic) MerchantListItemModel *merchantItem;


@end
