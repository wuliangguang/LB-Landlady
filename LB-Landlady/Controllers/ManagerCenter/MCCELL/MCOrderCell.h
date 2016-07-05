//
//  MCOrderCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListDetailModel.h"

@interface MCOrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UIImageView *orderImageView;
@property (strong, nonatomic) IBOutlet UILabel *orderNameLab;
@property (strong, nonatomic) IBOutlet UILabel *perPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UILabel *totalLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property(strong,nonatomic)OrderListDetailModel * model;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;



@property (strong, nonatomic) IBOutlet UILabel *stateLab;
@end
