//
//  WaiterListCell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/16.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaiterListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avater;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@end
