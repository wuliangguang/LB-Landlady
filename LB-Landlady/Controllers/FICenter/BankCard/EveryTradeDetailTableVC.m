//
//  EveryTradeDetailTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/19.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "EveryTradeDetailTableVC.h"
#import "OrderStatusCell.h"
#import "CheckDetailCell.h"

@interface EveryTradeDetailTableVC ()

@end

@implementation EveryTradeDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易明细";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            OrderStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderNum"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderStatusCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.orderNumLab.text = _model.bank_w_id;
            //0:已提现 1：审核中 2：未通过
            switch (_model.status) {
                case 0:
                    cell.orderStatusLab.text = @"已提现";
                    break;
                   case 1:
                    cell.orderStatusLab.text = @"审核中";
                    cell.orderStatusLab.backgroundColor = LD_COLOR_FOUR;
                    break;
                    case 2:
                    cell.orderStatusLab.text = @"未通过";
                    break;
                default:
                    break;
            }
            
            
            return cell;
        }
            
        default:
        {
            CheckDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"check_detail"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CheckDetailCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cardNumberLabel.text = _model.banknum;
            cell.timeLabel.text = _model.createTime;
            cell.maneyLabel.text = [NSString stringWithFormat:@"-%@",_model.amount];
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 44;
    }else
    {
        return 50;
    }
}


@end
