//
//  WaiterListCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/16.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "WaiterListCell.h"

@implementation WaiterListCell

- (void)awakeFromNib {
    // Initialization code
    self.avater.layer.cornerRadius = 20.0;
    self.avater.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
