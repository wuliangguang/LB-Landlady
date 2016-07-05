//
//  FM_productList_cell.h
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/16.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinacialProductListModel.h"

@interface FM_productList_cell : UITableViewCell
@property(nonatomic,strong)FinacialProductListModel * model;

@property (strong, nonatomic) IBOutlet UILabel *nameLab;

@property (strong, nonatomic) IBOutlet UILabel *descriptionLab;
@property (strong, nonatomic) IBOutlet UILabel *rateLab;

@end
