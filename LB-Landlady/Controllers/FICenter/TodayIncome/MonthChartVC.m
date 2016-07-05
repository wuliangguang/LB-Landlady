//
//  TotalChartVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "MonthChartVC.h"
#import "DataScrollView.h"
#import "Mommon_web_Cell.h"
#import "Momomon_manager_header_Cell.h"
//#import "MM_total_Model.h"
#import "MM_ChartModel.h"
@interface MonthChartVC ()
//@property(nonatomic,assign)NSInteger year;


@property(nonatomic,copy)NSString * month;
@property(nonatomic,strong)NSArray * categroyArr;
@property(nonatomic,strong)NSMutableArray * yDataArr;
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic,strong)NSArray * modelArr;
@property(nonatomic,strong)MM_ChartModel * model;
@property(nonatomic,assign)int tip;
@property(nonatomic,strong)NSString * onlineCount;
@property(nonatomic,strong)NSString * OfflineCount;
@property(nonatomic,assign)CGFloat amountPrice;


@end

@implementation MonthChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本年月度收入";
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSDate *curDate  =[NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *com = [cal components: NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:curDate];
    self.month = [NSString stringWithFormat:@"%ld",(long)com.month];
    
    [self getMonthOffline:[NSString stringWithFormat:@"%ld-%ld",(long)com.year,(long)com.month]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -----tableview  Data  Delegate-----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"scroller"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scroller"];
                DataScrollView * scrollerView = [[DataScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
                scrollerView.fromVC = FROM_Month;
                scrollerView.ChangeDateWhenClickButton = ^(NSString * selectMonth, NSInteger selectYear){
                    //获取每个月的收入金额
                    if (_modelArr.count!=0) {
                        for (MM_ChartModel * model in _modelArr) {
                            if ([model.datetime floatValue] == [selectMonth floatValue]) {
                                _model = model;
                                _amountPrice = [_model.price floatValue];
                            }else
                            {
                                _amountPrice = 0;
                            }
                        }
                        
                        
                    }

//                    if (_modelArr.count != 0) {
//                        _model = _modelArr[[selectMonth integerValue]-1];
//                        _amountPrice = [_model.price floatValue];
//                    }
                    
                    [_tableview reloadData];
                    self.month = selectMonth;
                };
                [cell addSubview:scrollerView];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 1:
        {
            Momomon_manager_header_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"mm_header"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Momomon_manager_header_Cell" owner:self options:nil]lastObject];
            }
            cell.MM_headerLab.text = [NSString stringWithFormat:@"本年%@月收入(元)",self.month];
            cell.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",(float)_amountPrice];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 2:
        {
            Mommon_web_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"web"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"Mommon_web_Cell" owner:self options:nil]lastObject];
            }
            cell.tip = 1;
            _yDataArr = [[NSMutableArray alloc] init];
            cell.type = @"pie";
            if (_modelArr.count != 0) {
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                cell.onLineLab.text = [NSString stringWithFormat:@"%.2f",[_onlineCount floatValue]];
                [dic setObject:_onlineCount forKey:@"value"];
                [dic setObject:@"在线收入" forKey:@"name"];
                [self.yDataArr addObject:dic];
                NSMutableDictionary * storeDic = [NSMutableDictionary dictionary];
                
                cell.storeLab.text = [NSString stringWithFormat:@"%.2f",[_OfflineCount floatValue]];
                [storeDic setObject:_OfflineCount forKey:@"value"];
                [storeDic setObject:@"到店收入" forKey:@"name"];
                [self.yDataArr addObject:storeDic];
                cell.yArray = self.yDataArr;

            }
            else
            {
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                cell.onLineLab.text = @"0.00";
                [dic setObject:@"0" forKey:@"value"];
                [dic setObject:@"在线收入" forKey:@"name"];
                [self.yDataArr addObject:dic];
                NSMutableDictionary * storeDic = [NSMutableDictionary dictionary];
                
                cell.storeLab.text = @"0.00";
                [storeDic setObject:@"0" forKey:@"value"];
                [storeDic setObject:@"到店收入" forKey:@"name"];
                [self.yDataArr addObject:storeDic];
                cell.yArray = self.yDataArr;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell ;
        }
        default:{
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 80;
            
        case 1:
            return 140;
            
        case 2:
            return 280;
            
        default:
            return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 2:
            return 10.0;
            
        default:
            return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark ------NetRequest-------
-(void)getMoneyAccountWithMonth:(NSString *)datetime
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getAmountByMonthUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@",responseObject);
            _modelArr = [MM_ChartModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"amountList"]];
            
            if (_modelArr.count!=0) {
                for (MM_ChartModel * model in _modelArr) {
                    if ([model.datetime floatValue] == [[[datetime componentsSeparatedByString:@"-"]lastObject] floatValue]) {
                        _model = model;
                        _amountPrice = [_model.price floatValue];
                    }
                }
               
                
            }
//            self.tip = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
            });
            
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
}

-(void)getMonthOnline:(NSString *)datetime
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOnlineCountByMonthUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [params setObject:datetime forKey:@"datetime"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@",responseObject);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                _onlineCount = responseObject[@"data"][@"count"];
                [self getMoneyAccountWithMonth:datetime];
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
}

-(void)getMonthOffline:(NSString *)datetime
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOfflineCountByMonthUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [params setObject:datetime forKey:@"datetime"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@",responseObject);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                _OfflineCount = responseObject[@"data"][@"count"];
                [self getMonthOnline:datetime];
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
}

@end
