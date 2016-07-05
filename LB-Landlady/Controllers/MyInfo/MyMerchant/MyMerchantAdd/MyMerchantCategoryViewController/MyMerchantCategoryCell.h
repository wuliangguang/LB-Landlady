//
//  MyMerchantCategoryCell.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryModel.h"

@interface MyMerchantCategoryCell : UITableViewCell

@property (nonatomic, copy) void (^callbackHandler)(IndustryModel *model);
@property (nonatomic) IndustryModel *model;
@end
