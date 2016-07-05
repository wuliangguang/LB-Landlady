//
//  IncomeTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "IncomeTableVC.h"
#import "TableVCCell.h"
// #import "OnlineChart.h"
#import "TodayIncomeOnlineVC.h"
#import "TodayIncomeOfflineVC.h"
#import "NSDate+Helper.h"
#import "IncomeDataModel.h"
#import "TodayIncomeOnlineVC.h"
#import "TodayIncomeOfflineVC.h"

@interface IncomeTableVC ()

@end

@implementation IncomeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人经营收入";
    
    // 获取今日收入
    [self getDayCount];
    
}

/**
 *  获取今日收入
 */
- (void)getDayCount {
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSString *queryType = @"today";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",queryType,userId,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"userId":userId,@"queryType":queryType,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService getCountByDay] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"-------今日在线收入:%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            IncomeDataModel *income  = (IncomeDataModel *)commonModel.data;
            // NSLog(@"%@", income.count);
            if ([income.totalAmt isEqualToString:@"0"]) {
                self.todayIncomeLab.text = income.totalAmt;
            }else {
                self.todayIncomeLab.text = [NSString stringWithFormat:@"%.2f",[income.totalAmt floatValue]/100];
            }
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

#pragma mark - <UITableViewDelegate & UITableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.01 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 120 : 44;
}

// 隐藏上周第日收入｜本年月度收入
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSString *xib = NSStringFromClass([TodayIncomeVC class]); // 基类
        switch (indexPath.row) {
            case 0: { // 今日在线收入
                TodayIncomeOnlineVC *controller = [[TodayIncomeOnlineVC alloc] initWithNibName:xib bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
            case 1: { // 今日到店收入
                TodayIncomeOfflineVC *controller = [[TodayIncomeOfflineVC alloc] initWithNibName:xib bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

@end
