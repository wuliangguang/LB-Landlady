//
//  FM_IncomeRecoder_Cell.h
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/9.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FM_detailModel.h"


@interface FM_IncomeRecoder_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *amountLab;
@property(nonatomic,strong)FM_detailModel * model;
@end
