//
//  OrderDetailTVC.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import ""


@interface OrderDetailTVC : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLab;
@property (strong, nonatomic) IBOutlet UILabel *linkerNameLab;

@property (strong, nonatomic) IBOutlet UILabel *linkerTelLab;
@property (strong, nonatomic) IBOutlet UILabel *linkerAddressLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIImageView *orderImageView;
@property (strong, nonatomic) IBOutlet UILabel *orderNameLab;
@property (strong, nonatomic) IBOutlet UILabel *orderPerPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLab;

@property (strong, nonatomic) IBOutlet UITableViewCell *lastCell;

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString * orderId;


@end
