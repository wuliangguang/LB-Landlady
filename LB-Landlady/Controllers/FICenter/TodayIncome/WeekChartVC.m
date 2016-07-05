//
//  WeekChartVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "WeekChartVC.h"
#import "Mommon_web_Cell.h"
#import "MM_Week_model.h"

@interface WeekChartVC ()
@property(nonatomic,strong)NSArray * modelArr;
@property(nonatomic,strong)NSMutableArray * yDataArr;
@property(nonatomic,strong)NSString * onlineCount;
@property(nonatomic,strong)NSString * OfflineCount;
@property(nonatomic,assign)int tip;
@end

@implementation WeekChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上周每日收入";
    _yDataArr = [[NSMutableArray alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//- (NSMutableArray *)yDataArr {
//    if (_yDataArr == nil) {
//        _yDataArr = [[NSMutableArray alloc] init];
//    }
//    return _yDataArr;
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getLastweekOnline];
    
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
    Mommon_web_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"web"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Mommon_web_Cell" owner:self options:nil]lastObject];
    }
        if (indexPath.section == 0) {
        cell.type = @"pie";
        if (_modelArr.count != 0)
        {
            [self.yDataArr removeAllObjects];
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
            [self.yDataArr removeAllObjects];
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
        
        
    } else if (indexPath.section == 1)
    {
        cell.type = @"line";
        
        if (_modelArr.count == 0) {
            
            cell.yArray = @[@0,@0,@0,@0,@0,@0,@0];
            cell.xData = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
        }else
        {
            NSMutableArray * xArr = [[NSMutableArray alloc]init];
            NSMutableArray * yArr = [[NSMutableArray alloc]init];
            for (MM_Week_model * model in _modelArr) {
                [xArr addObject:model.datetime];
                [yArr addObject:model.count];
            }
            cell.xData = xArr;
            cell.yArray = yArr;
        }
        
        
    }
    cell.xName = @"时间";
    cell.yName = @"金额";
    cell.tip = 1;
    return cell ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
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

-(void)getLastweekEachDayIncome//上周每日收入
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getAmountByWeekUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@ ",responseString);
                _modelArr = [MM_Week_model mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"amountList"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
    
}
-(void)getLastweekOffline//上周每日收入
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOfflineLastWeekCountUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@ ",responseString);
            self.OfflineCount = responseObject[@"data"][@"count"];
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                [self getLastweekEachDayIncome];
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
    
}
-(void)getLastweekOnline
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getOnlineLastWeekCountUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject == %@ ",responseString);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                self.onlineCount = responseObject[@"data"][@"count"];
                [self getLastweekOffline];
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
    
}
@end
