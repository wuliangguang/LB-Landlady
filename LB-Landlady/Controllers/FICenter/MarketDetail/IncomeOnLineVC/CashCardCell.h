//
//  CashCardCell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/10/28.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashCardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bankImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;

@end
