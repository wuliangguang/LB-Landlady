//
//  CheckDetailCell.h
//  MeZoneB_Bate
//
//  Created by 喻晓彬 on 15/10/28.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckDetailModel.h"
#import "MM_IncomeModel.h"
@interface CheckDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *maneyLabel;

- (void)showCellWirhModel:(CheckDetailModel *)model;

- (void)showIncomeDetailWithModel:(MM_IncomeModel *)model;
@end
