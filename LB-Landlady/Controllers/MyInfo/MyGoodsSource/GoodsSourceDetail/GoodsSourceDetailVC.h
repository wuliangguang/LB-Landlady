//
//  GoodsSourceDetailVC.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSourceProductModel.h"

@interface GoodsSourceDetailVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic) GoodSourceProductModel *productModel;

@end
