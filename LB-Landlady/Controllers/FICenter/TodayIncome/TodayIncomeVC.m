//
//  TodayIncomeVC.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/4/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "TodayIncomeVC.h"
#import "MM_ChartModel.h"
#import "TodayIncomeModel.h"
#import "OrderQueryCell.h"
#import "OrserQueryModel.h"
@interface TodayIncomeVC ()
@property(nonatomic,strong)MM_ChartModel * model;
@end

@implementation TodayIncomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _detailArr = [NSMutableArray array];
    [self registXibCell:[Momomon_manager_header_Cell class]];
    [self registXibCell:[Mommon_web_Cell class]];
    [self registXibCell:[Mommon_income_titleCell class]];
    [self registXibCell:[OrderQueryCell class]];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self.tableView reloadData];
}

- (void)registXibCell:(Class)cls {
    NSString *str = NSStringFromClass(cls);
    [self.tableView registerNib:[UINib nibWithNibName:str bundle:nil] forCellReuseIdentifier:str];
}

- (id)loadXibCell:(Class)cls indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cls) forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cls) owner:self options:nil] firstObject];
    }
    return cell;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 3 ? _detailArr.count : 1; // return _orderDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            Momomon_manager_header_Cell *cell = [self loadXibCell:[Momomon_manager_header_Cell class] indexPath:indexPath];
//            cell.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",(float)_totalAccount];
            cell.selectionStyle = UITableViewScrollPositionNone;
            return cell;
        }
        case 1: {
            __weak __typeof(self) weakself = self;
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"scroller"];
            if (!cell) {
                cell                          = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scroller"];
                DataScrollView * scrollerView = [[DataScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
                scrollerView.fromVC           = FROM_DayOnline;
                scrollerView.ChangeDateWhenClickButton = ^(NSString * selectDay, NSInteger selectMonth) {
                    NSString *dateStr = [NSString stringWithFormat:@"%ld%.2ld%@", [[NSDate date] year], selectMonth, selectDay];
                  NSLog(@"-=======================[[NSDate date] year]:%@",dateStr);
                    [weakself getDetailIncomeOfDay:dateStr pageNumber:@"0"];
                };
                [cell addSubview:scrollerView];
            }
            return cell;
        }
        case 2: {
//            Mommon_web_Cell *cell = [self loadXibCell:[Mommon_web_Cell class] indexPath:indexPath];
//            cell.type = @"line";
//            cell.tip = 1;
//            if (_modelArr.count == 0) {
//                
//                cell.xData = @[@0,@0,@0,@0,@0,@0,@0];
//                cell.yArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
//            }else
//            {
//                NSMutableArray * xArr = [[NSMutableArray alloc]init];
//                NSMutableArray * yArr = [[NSMutableArray alloc]init];
//                for (TodayIncomeModel * model in _modelArr) {
//                    [xArr addObject:model.datetime];
//                    [yArr addObject:model.price];
//                }
//                cell.xData = xArr;
//                cell.yArray = yArr;
//            }
//            cell.xName = @"时间段";
//            cell.yName = @"收入金额";
            Mommon_income_titleCell *cell = [self loadXibCell:[Mommon_income_titleCell class] indexPath:indexPath];
            cell.selectionStyle = UITableViewScrollPositionNone;
            return cell;
        }
        case 3: {
            OrderQueryCell *cell = [self loadXibCell:[OrderQueryCell class] indexPath:indexPath];
            OrserQueryModel *model = _detailArr[indexPath.row];
            [cell showAndUpdateModel:model];
            cell.selectionStyle = UITableViewScrollPositionNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 140;
        case 1:
            return 80;
        case 2:
            return 40;
        case 3:
            return 122;
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
@end
