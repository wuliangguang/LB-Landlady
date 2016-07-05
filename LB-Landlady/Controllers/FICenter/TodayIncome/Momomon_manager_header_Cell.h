//
//  Momomon_manager_header_Cell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/19.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDataModel.h"

@interface Momomon_manager_header_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *MM_headerLab;
@property (strong, nonatomic) IBOutlet UILabel *       MM_moneyLab;

@property (nonatomic) IncomeDataModel *income;
@end
