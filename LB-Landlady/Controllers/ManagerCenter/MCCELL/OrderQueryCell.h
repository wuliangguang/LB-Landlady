//
//  OrderQueryCell.h
//  ZBL
//
//  Created by 张伯林 on 16/3/31.
//  Copyright © 2016年 张伯林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrserQueryModel.h"
@interface OrderQueryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *OrderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhifuIdeaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuFuFangShiLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
- (void)showAndUpdateModel:(OrserQueryModel *)model;
@end
