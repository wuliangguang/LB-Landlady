//
//  TodayIncomeCCell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDataModel.h"

@interface TodayIncomeCCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (nonatomic) IncomeDataModel *income;
@end
