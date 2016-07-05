//
//  TodayIncomeVC.h
//  LB-Landlady
//
//  Created by 刘威振 on 3/4/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Momomon_manager_header_Cell.h"
#import "Mommon_web_Cell.h"
#import "Mommon_income_titleCell.h"
#import "CheckDetailCell.h"
#import "DataScrollView.h"
#import "NSDate+Escort.h"
#import "NSDate+Helper.h"

@interface TodayIncomeVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign)NSInteger totalAccount;
@property(nonatomic)NSArray * modelArr;
@property(nonatomic)NSMutableArray * detailArr;

//@property ()

/**
 *  获取某天收入 子类实现
 */
- (void)getIncomeOfDay:(NSDate *)date;

/**
 *  获取某天详细收入 子类实现
 */
- (void)getDetailIncomeOfDay:(NSString *)date pageNumber:(NSString *)pageNumber;


- (void)getIncomeOfTwoHour:(NSDate *)date;
@end
