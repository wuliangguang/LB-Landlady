//
//  TodayIncomeOnlineVC.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/4/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "TodayIncomeOnlineVC.h"
#import "NSDate+Helper.h"
#import "TodayIncomeModel.h"
#import "OrserQueryModel.h"
@interface TodayIncomeOnlineVC ()
{
    NSInteger _pageNum;
}

@end

@implementation TodayIncomeOnlineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self getIncomeOfDay];
    NSDate *date = [NSDate date];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    NSString *year = [str substringWithRange:NSMakeRange(0,4)];
    NSString *month = [str substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [str substringWithRange:NSMakeRange(8, 2)];
    NSString *ymd = [NSString stringWithFormat:@"%@%@%@",year,month,day];
    // NSLog(@"------=-=-=-=-=-=-=-=-=-=-date:%@",ymd);
    [self getDetailIncomeOfDay:ymd pageNumber:[NSString stringWithFormat:@"%ld",_pageNum]];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 header ");
        _pageNum = 0;
        [self getDetailIncomeOfDay:ymd pageNumber:[NSString stringWithFormat:@"%ld",_pageNum]];
        [self getIncomeOfDay];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 footer");
        _pageNum ++;
        [self getDetailIncomeOfDay:ymd pageNumber:[NSString stringWithFormat:@"%ld",_pageNum]];
        //[self getIncomeOfDay];
    }];
    
}

- (void)initUI {
    Momomon_manager_header_Cell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.MM_headerLab.text = self.title = @"今日收入";
}
#pragma mark ------NetRequest-------

/**
 *  获取指定某天收入
 */
- (void)getIncomeOfDay {
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSString *queryType = @"today";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",queryType,userId,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"userId":userId,@"queryType":queryType,@"sign":sign};

    [S_R LB_GetWithURLString:[URLService getCountByDay] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            IncomeDataModel *income = commonModel.data;
            Momomon_manager_header_Cell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.income = income;
        }
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    } WithController:self];
}
///**
// *  线上每天不同时间段的经营收入
// *
// */
//- (void)getIncomeOfTwoHour:(NSDate *)date {
//    NSDictionary *params = @{
//                             @"businessId" : App_User_Info.myInfo.businessInfo.businessId,
//                             @"datetime" : date.toString
//                             };
//    [S_R LB_GetWithURLString:[URLService getOnlineCountByTwoHoursUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
//        FMLog(@"%@",responseObject);
//        self.modelArr = [TodayIncomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"detailList"]];
//        [self getDetailIncomeOfDay:date];
//    } failure:^(NSError *error) {
//        FMLog(@"error == %@",error);
//    } WithController:self];
//}
//
/**
 *  获取某天详细收入
 */
- (void)getDetailIncomeOfDay:(NSString *)date pageNumber :(NSString *)pageNumber{
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    //NSLog(@"----------%@",userId);
    //NSString *userId = @"222";
    NSString *tradeTime = date;
    NSString *currentPageNum = pageNumber;
    NSString *pageSize = @"20";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *status= @"success";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@",currentPageNum,pageSize,status,tradeTime,userId,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"userId":userId,@"currentPageNum":currentPageNum,@"pageSize":pageSize,@"status":status,@"tradeTime":tradeTime,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService getOfflineCountByBusinessUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        FMLog(@"获取某天详细收入:%@", responseString);
        if ([currentPageNum isEqualToString:@"0"]) {
            [self.detailArr removeAllObjects];
        }
        NSArray *orderList = ((NSDictionary *)responseObject)[@"data"];
        for (NSDictionary *dict in orderList) {
            OrserQueryModel *model = [[OrserQueryModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.detailArr addObject:model];
        }
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    } WithController:self];
}

@end
