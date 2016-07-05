//
//  FM_EveryDayIncomeTVC.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/9.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FM_EveryDayIncomeTVC.h"
#import "DataScrollView.h"
#import "Mommon_income_titleCell.h"
#import "FM_IncomeRecoder_Cell.h"
#import "NSDate+Escort.h"
#import "ProductDetailTVC.h"
#import "UITableViewCell+ZZAddLine.h"
//#import "MZFincialProductModel.h"

@interface FM_EveryDayIncomeTVC ()
@property(nonatomic,copy)NSString * month;
@property(nonatomic,copy)NSString * year;
//@property(nonatomic,strong)MZFincialProductModel * mzFincialProductModel;
@end

@implementation FM_EveryDayIncomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate * date = [NSDate date];
    self.month =[date toStringWithFormat:@"MM"];
    self.title = @"每日收益";
    self.year = [date toStringWithFormat:@"yyyy"];
//    [self getDetailIncomeForMonthWithDate:[NSString stringWithFormat:@"%@-%@",self.year,self.month]];
}


//-(void)getDetailIncomeForMonthWithDate:(NSString *)date
//{
//    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSString * pathString = [URLService monthIncomeForfinancial];
//        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//        [param setObject:date forKey:@"date"];
//        [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:GET_LASTER_USER_IPHONE] forKey:@"username"];
//        [NET_REQUEST MeZoneGetWithURLString:pathString WithParams:param WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            _mzFincialProductModel = [MZFincialProductModel objectWithKeyValues:responseObject];
//            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//        } WithController:self];
//    });
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 2:
//            return _mzFincialProductModel.result.count;
#warning _mzFincialProductModel.result.count;
            return 10;
            
        default:
            return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"scroller"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scroller"];
                DataScrollView * scrollerView = [[DataScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
                scrollerView.fromVC = FROM_Finacial;
                scrollerView.ChangeDateWhenClickButton = ^(NSString * selectMonth, NSInteger selectYear){
                    self.month = selectMonth;
//                    [self getDetailIncomeForMonthWithDate:[NSString stringWithFormat:@"%@-%@",self.year,self.month]];
                    NSIndexSet * set = [NSIndexSet indexSetWithIndex:1];
                    [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [cell addSubview:scrollerView];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            case 1:
            {
                Mommon_income_titleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MM_titleCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"Mommon_income_titleCell" owner:self options:nil]lastObject];
                }
                if (indexPath.row == 0) {
                    cell.showCustomLine = YES;
                }
                cell.MM_titleLab.text =[NSString stringWithFormat:@"%@月收益记录",self.month];
                cell.topLine.alpha = 0;
                cell.bottom.alpha = 0;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            };
            
        default:
        {
            FM_IncomeRecoder_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"recoder"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_IncomeRecoder_Cell" owner:self options:nil]lastObject];
            }
//            cell.model = _mzFincialProductModel.result[indexPath.row];
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 80;
            case 1:
            return 40;
        default:
            return 76;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return 10;
            
        default:
            return 0.01;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        ProductDetailTVC * detailVC = [[ProductDetailTVC alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

@end
