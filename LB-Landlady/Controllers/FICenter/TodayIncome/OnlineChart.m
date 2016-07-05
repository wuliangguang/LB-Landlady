//
//  ChartVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "OnlineChart.h"
#import "Momomon_manager_header_Cell.h"
#import "CheckDetailCell.h"
#import "Mommon_income_titleCell.h"
#import "Mommon_web_Cell.h"
#import "MM_IncomeModel.h"
#import "MM_ChartModel.h"
#import "MJRefresh.h"
#import "NSDate+Helper.h"

@interface OnlineChart ()

@property (nonatomic, assign) NSInteger      year;
@property (nonatomic, strong) NSMutableArray * orderDetails;
@property (nonatomic, assign) float          MM_totalMoney;
@property (nonatomic, strong) MBProgressHUD  * hud;
// @property (nonatomic, copy  ) NSString       * types;
@property (nonatomic, strong) NSArray        * modelArray;
@property (nonatomic, assign) int            tip;
@property (nonatomic        ) NSInteger      page;

@end

@implementation OnlineChart

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *todayStr = [[NSDate date] toStringWithFormat:nil];
    self.year = [[todayStr substringToIndex:4] integerValue];
    if ([self.fromWhere isEqualToString:@"online"]) {
        self.title = @"今日在线收入";

        [self getOnlineAllOrderDetail:todayStr]; // 今日在线收入
    } else {
        self.title = @"今日到店收入";
        // [self getOfflineAllOrderDetail:todayStr];
        // [self getOfflineIncomeTimePhase:todayStr];
        // [self getOfflineIncomeAmount];
    }
}

#pragma mark -----tableview  Data  Delegate-----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 4:
#warning 订单Section
            return _orderDetails.count;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            Momomon_manager_header_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"mm_header"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Momomon_manager_header_Cell" owner:self options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if ([self.fromWhere isEqualToString:@"online"]) {
                cell.MM_headerLab.text = @"今日在线收入(元)";
            }
            cell.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",_MM_totalMoney];
            
            return cell;
        }
        case 1: {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"scroller"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scroller"];
                DataScrollView * scrollerView = [[DataScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
                scrollerView.fromVC = FROM_DayOnline;
                scrollerView.ChangeDateWhenClickButton = ^(NSString * selectDay, NSInteger selectMonth){
                };
                [cell addSubview:scrollerView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        case 2: { //chartwebView
            Mommon_web_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"web"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"Mommon_web_Cell" owner:self options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tip = self.tip;
            cell.type = @"line";
            if (_modelArray.count!=0) {
                NSMutableArray * timeArr = [[NSMutableArray alloc]init];
                NSMutableArray * priceArr = [[NSMutableArray alloc]init];
                for (MM_ChartModel * model in _modelArray) {
                    [timeArr addObject:model.datetime];
                    [priceArr addObject:model.price];
                }
                cell.xData = timeArr;
                cell.yArray = priceArr;
            }
            cell.xName = @"时间段";
            cell.yName = @"收入金额";
            return cell ;
        }
        case 3: {
            Mommon_income_titleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MM_titleCell"];
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Mommon_income_titleCell" owner:self options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        case 4: {
            CheckDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"check_detail"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CheckDetailCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            MM_IncomeModel * model = self.orderDetails[indexPath.row];
            [cell showIncomeDetailWithModel:model];
            return cell;
        }
        default: {
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 140;
        case 1:
            return 80;
        case 2:
            return 300;
        case 3:
            return 40;
        case 4:
            return 60;
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return 10.0;
            
        default:
            return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark ------NetRequest-------
// 线下收入
- (void)getOfflineAllOrderDetail:(NSString *)todayStr {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getDetailofflineUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [params setObject:todayStr forKey:@"datetime"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject === %@ ",responseObject);
            NSArray *array = [MM_IncomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"detailList"]];
            if (array.count <= 0) {
                return ;
            }
            _orderDetails = [[NSMutableArray alloc] init];
            [self.orderDetails addObjectsFromArray:array];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

// 线上收入
/**
	* @see 获取某天经营总收入
	* @author kai.li
	*	@param	businessId	string			店铺ID
	*	@param	dateTime	string			日期（YYYY-mm-dd）
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	*		count:XXXXXX
	* 	}
	*/
//@RequestMapping(value="/transaction/getCountByDay.do" )
// type:
// 0：今天总收入
// 1：今天在线收入
// 2：到店收入
//+(NSString *)getCountByDay;
- (void)getOnlineAllOrderDetail:(NSString * )todayStr {
    [S_R LB_GetWithURLString:[URLService getCountByDay] WithParams:@{@"businessId" : App_User_Info.myInfo.userModel.defaultBusiness, @"dateTime" : todayStr, @"type" : @"1"} WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            IncomeDataModel *income = commonModel.data;
            Momomon_manager_header_Cell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            NSLog(@"%@", income.count);
            cell.income = income;
        }
//        IncomeDataModel *income = 
        NSLog(@"%@", responseString);
    } failure:^(NSError *error) {
        
    } WithController:self];
    
    /**
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getDetailOnlineUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessInfo.businessId forKey:@"businessId"];
        [params setObject:todayStr forKey:@"datetime"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject === %@ ",responseObject);
            
            NSArray *array = [MM_IncomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"detailList"]];
            if (array.count <= 0) {
                return ;
            }
            _orderDetails = [[NSMutableArray alloc] init];
            [self.orderDetails addObjectsFromArray:array];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
     */
}

- (void)getOfflineIncomeAmount {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOfflineCountByBusinessUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject === %@ ",responseObject);
            
        } failure:^(NSError *error) {
            
        } WithController:self];
    });

}

// 在线或者到店收入
- (void)getOnlineIncomeAmount{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOnlineCountByBusinessUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject === %@ ",responseObject);
            
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

// 今日到店时间分布
- (void)getOnlineIncomeTimePhase:(NSString *)tadayStr {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOnlineCountByTwoHoursUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        FMLog(@"%@",App_User_Info.myInfo.businessModel.businessId);
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        FMLog(@"= %@",tadayStr);
        [params setObject:tadayStr forKey:@"datetime"];
        
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@",responseObject);
            _modelArray = [MM_ChartModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"detailList"]];
//            _tip = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
                
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

// 今日到店时间分布
- (void)getOfflineIncomeTimePhase:(NSString * )tadayStr{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOfflineCountByTwoHoursUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [params setObject:tadayStr forKey:@"datetime"];
        
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@",responseObject);
            _modelArray = [MM_ChartModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"detailList"]];
            _tip = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
                
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
}

@end
