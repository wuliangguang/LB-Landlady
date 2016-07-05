//
//  MY_MoneyManagmentTVC.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/8.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "MY_MoneyManagmentTVC.h"
#import "FP_Name_Cell.h"
#import "FP_HeaderView_Cell.h"
#import "Mommon_income_titleCell.h"
#import "FM_EveryDayIncomeTVC.h"


@interface MY_MoneyManagmentTVC ()


@end

@implementation MY_MoneyManagmentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];

}

- (void)initUI {
    self.title = @"我的理财";
    self.tableView.backgroundColor = LD_COLOR_FOURTEEN;
}




#pragma mark --------BtnClick-------------
/**
 *  查看更多
 */
- (IBAction)moreDetailBtnClic:(id)sender {
    FM_EveryDayIncomeTVC * everyDayIncomeVC = [[FM_EveryDayIncomeTVC alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:everyDayIncomeVC animated:YES];
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 210;
        case 1:
            return 40;
        default:
            return 76;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
//        return self.productModel.result.count;
        return 10;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            FP_HeaderView_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"FP_header"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"FP_HeaderView_Cell" owner:self options:nil] lastObject];
            }

            return cell;
        }
        case 1: {
            Mommon_income_titleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MM_titleCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"Mommon_income_titleCell" owner:self options:nil]lastObject];
            }
            cell.MM_titleLab.text = @"我的理财";
            cell.topLine.alpha    = 0;
            cell.bottom.alpha     = 0;
            cell.selectionStyle   = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default: {
            FP_Name_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"FP_Name"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"FP_Name_Cell" owner:self options:nil]lastObject];
            }
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }else
    {
        return 0.01;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
@end
