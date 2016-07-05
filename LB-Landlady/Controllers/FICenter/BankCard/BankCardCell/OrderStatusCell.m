//
//  OrderStatusCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/19.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "OrderStatusCell.h"

@implementation OrderStatusCell

- (void)awakeFromNib {
    // Initialization code
    dispatch_async(dispatch_get_main_queue(), ^{
        _orderStatusLab.layer.cornerRadius = 2;
        _orderStatusLab.clipsToBounds = YES;
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
