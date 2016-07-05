//
//  ProductDetailTVC.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/9.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "ProductDetailTVC.h"
#import "FM_Detail_name_Cell.h"
#import "FM_Income_Detail_Cell.h"
#import "FM_redTitle_cell.h"
#import "FM_IncomeRecoder_Cell.h"
#import "FM_EveryDayIncomeTVC.h"
#import "RedeemTVC.h"

@interface ProductDetailTVC ()

@end

@implementation ProductDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.name;
    [self initRightButton];
}
#pragma mark ------- init ------
-(void)initRightButton{
    UIButton * rightBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBTN setImage:[UIImage imageNamed: @"FP_Dollar"] forState:UIControlStateNormal];
    rightBTN.frame = CGRectMake(0, 0, 30, 30);
    [rightBTN addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightBTN];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark ---------BTN Click -----
-(void)rightButtonClick
{
    UIStoryboard * stroyBoard = [UIStoryboard storyboardWithName:@"RedeemTVC" bundle:nil];
    RedeemTVC * controller = [stroyBoard instantiateViewControllerWithIdentifier:@"redeem"];
    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark - Table view data source -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
        default:
            return 10;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    FM_Detail_name_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"FM_Detail_Name"];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_Detail_name_Cell" owner:self options:nil]lastObject];
                    }
                    cell.detailNameLAB.text = self.model.name;
                    cell.daysCountLAB.text = [NSString stringWithFormat:@"剩余%d天",[self.model.days intValue]];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    
                default:
                {
                    FM_Income_Detail_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"incomeDetail"];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_Income_Detail_Cell" owner:self options:nil]lastObject];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
        }
            
        default:
        {
            switch (indexPath.row) {
                case 0:
                {
                    FM_redTitle_cell * cell = [tableView dequeueReusableCellWithIdentifier:@"red"];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_redTitle_cell" owner:self options:nil]lastObject];
                    }
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    
                default:
                {
                    FM_IncomeRecoder_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"recoder"];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_IncomeRecoder_Cell" owner:self options:nil]lastObject];
                    }
                    return cell;
                }
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                FM_EveryDayIncomeTVC * everyDayIncome = [[FM_EveryDayIncomeTVC alloc]initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewController:everyDayIncome animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    return 44;
                    
                default:
                    return 68;
            }
        }
            
        default:
        {
            switch (indexPath.row) {
                case 0:
                    return 30;
                    
                default:
                    return 44;
            }
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
