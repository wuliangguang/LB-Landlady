//
//  PayTableVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/17.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashCardCell.h"

@interface PayTableVC : UITableViewController

@property (strong, nonatomic) IBOutlet UITableViewCell *section1Cell;
@property (strong, nonatomic) IBOutlet UIImageView *headerIMGView;
@property (strong, nonatomic) IBOutlet UILabel *nameLAB;
@property (strong, nonatomic) IBOutlet UILabel *accountLab;

@property (strong, nonatomic) IBOutlet UITextField *moneyTF;

@end
