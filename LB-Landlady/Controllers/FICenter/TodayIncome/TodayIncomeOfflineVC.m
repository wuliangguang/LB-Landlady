//
//  TodayIncomeOfflineVC.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/4/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "TodayIncomeOfflineVC.h"
#import "TodayIncomeModel.h"

@interface TodayIncomeOfflineVC ()

@end

@implementation TodayIncomeOfflineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日到店收入";
    [self getIncomeOfDay:[NSDate date]];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------NetRequest-------
/**
 *  获取指定某天收入
 */
- (void)getIncomeOfDay:(NSDate *)date {
    NSDictionary *params = @{
                             @"businessId" : App_User_Info.myInfo.businessModel.businessId,
                             @"dateTime" : date.toString,
                             @"type" : @"2"
                             };
    [S_R LB_GetWithURLString:[URLService getCountByDay] WithParams:params WithSuccess:^(id responseObject, id responseString) {
        FMLog(@"%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            IncomeDataModel *income = commonModel.data;
            Momomon_manager_header_Cell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.income = income;
            [self getIncomeOfTwoHour:date];
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}
/**
 *  线下每天不同时间段的经营收入
 *
 */
- (void)getIncomeOfTwoHour:(NSDate *)date {
    NSDictionary *params = @{
                             @"businessId" : App_User_Info.myInfo.businessModel.businessId,
                             @"datetime" : date.toString
                             };
    [S_R LB_GetWithURLString:[URLService getOfflineCountByTwoHoursUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
        FMLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
            self.modelArr = [TodayIncomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"detailList"]];
            [self getDetailIncomeOfDay:date];
        }
        
    } failure:^(NSError *error) {
        
    } WithController:self];
}
/**
 *  获取某天详细收入
 */
- (void)getDetailIncomeOfDay:(NSDate *)date {
    NSDictionary *params = @{
                             @"businessId" : App_User_Info.myInfo.businessModel.businessId,
                             @"datetime" : date.toString
                             };
    [S_R LB_GetWithURLString:[URLService getDetailofflineUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:nil];
        if (commonModel.code == SUCCESS_CODE) {
            self.detailArr = responseObject[@"data"][@"detailList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
        
    } failure:^(NSError *error) {
        
    } WithController:self];
}


@end
