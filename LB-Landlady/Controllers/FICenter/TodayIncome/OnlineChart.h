//
//  ChartVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataScrollView.h"

@interface OnlineChart : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong ) NSString  *namestr;
@property (strong, nonatomic) IBOutlet  UITableView *tableview;
@property (nonatomic,strong ) NSString  *fromWhere;

@end
