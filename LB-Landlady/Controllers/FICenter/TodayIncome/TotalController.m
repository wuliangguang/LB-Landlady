//
//  TotalController.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/20.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "TotalController.h"
#import "Momomon_manager_header_Cell.h"
#import "Mommon_web_Cell.h"
#import "MM_total_Model.h"

@interface TotalController ()

@property(nonatomic,strong)MM_total_Model * model;
@property(nonatomic,strong)NSMutableArray * yDataArr;
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic,assign)int tip;
@property(nonatomic,assign)float amount;
@property(nonatomic,assign)float onlineCount;
@property(nonatomic,assign)float offlineCount;
@end

@implementation TotalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"总收入";
    self.tableView.backgroundColor = LD_COLOR_FOURTEEN;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getTotalCountUrlRequest];
//    [self getTotalIncomeChart];
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
            Momomon_manager_header_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"mm_header"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Momomon_manager_header_Cell" owner:self options:nil]lastObject];
            }
            cell.MM_headerLab.text = @"总收入(元)";
            if (_amount == 0.00) {
                cell.MM_moneyLab.text = @"0";
            }else{
                cell.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",_amount];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 1:
        {
            Mommon_web_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"web"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"Mommon_web_Cell" owner:self options:nil]lastObject];
            }
            cell.type = @"pie";
            _yDataArr = [[NSMutableArray alloc]init];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            cell.onLineLab.text = [NSString stringWithFormat:@"%.2f",_onlineCount];
            [dic setObject:[NSNumber numberWithFloat:_onlineCount] forKey:@"value"];
            [dic setObject:@"在线收入" forKey:@"name"];
            [self.yDataArr addObject:dic];
            NSMutableDictionary * storeDic = [NSMutableDictionary dictionary];
            cell.storeLab.text = [NSString stringWithFormat:@"%.2f",_offlineCount];
            [storeDic setObject:[NSNumber numberWithFloat:_offlineCount] forKey:@"value"];
            [storeDic setObject:@"到店收入" forKey:@"name"];
            [self.yDataArr addObject:storeDic];
            cell.yArray = self.yDataArr;
            cell.tip = 1;
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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 140;
            
        case 1:
            return 280;
            
        default:
            return 0;
    }
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

-(void)getTotalCountUrlRequest
{
    NSString * pathStr = [URLService getCountByBusiness];
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSString *queryType = @"total";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",businessId,queryType,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"businessId":businessId,@"queryType":queryType,@"sign":sign};
    [S_R LB_GetWithURLString:pathStr WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        FMLog(@" =========================%@",responseObject);
        if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
            _amount = [responseObject[@"data"][@"totalAmt"] floatValue]/100;
            NSLog(@"-0-0-0-0-0-:%.2f",_amount);
            Momomon_manager_header_Cell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",_amount];
            [self getOnlineCountByBusiness];
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

// 线上
- (void)getOnlineCountByBusiness {
    [S_R LB_GetWithURLString:[URLService getOnlineCountByBusinessUrl] WithParams:@{@"businessId" : App_User_Info.myInfo.userModel.defaultBusiness} WithSuccess:^(id responseObject, id responseString) {
        if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
            _onlineCount = [responseObject[@"data"][@"count"] floatValue];
            [self getOfflineCountByBusiness];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

// 线下
- (void)getOfflineCountByBusiness {
    [S_R LB_GetWithURLString:[URLService getOfflineCountByBusinessUrl] WithParams:@{@"businessId" : App_User_Info.myInfo.userModel.defaultBusiness} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
            _offlineCount = [responseObject[@"data"][@"count"] floatValue];
//            self.tip = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}


@end
