//
//  TotalChartVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthChartVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
