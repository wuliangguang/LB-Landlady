//
//  FinancialProductsTVC.m
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/8.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FinancialProductsTVC.h"
#import "GM_ADCell.h"
#import "MY_MoneyManagmentTVC.h"
#import "FinancialMoreController.h"
#import "TermFinancialController.h"
#import "CurrentFinancialController.h"
#import "Momomon_manager_header_Cell.h"
#import "FM_MYFinacial_Cell.h"
#import "FM_productList_cell.h"




@interface FinancialProductsTVC ()
@property (nonatomic,strong)NSArray * finacialListArr;

@property(nonatomic,strong)NSArray * imageArr;

@end

@implementation FinancialProductsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                     = @"理财产品";
    self.tableView.backgroundColor = LD_COLOR_FOURTEEN;
    
//    [self fetchWebData];
}

-(void)initRightBarButtonItem
{
    __weak typeof(self) weakself = self;
//    [self addRightBarButtonWithImage:[UIImage imageNamed:@"More_R_Button"] clickHandler:^{
//        [weakself gotoFinancialMoreController];
//    }];
}

// 理财产品之更多
- (void)gotoFinancialMoreController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([FinancialMoreController class]) bundle:nil];
    FinancialMoreController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else
    {
        return 10;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 3:
//            return _mzFincialProductModel.result.count;
            return 10;
        default:
            return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            Momomon_manager_header_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"mm_header"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Momomon_manager_header_Cell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.MM_headerLab.text = @"理财总额(元)";
//            cell.MM_moneyLab.text = [NSString stringWithFormat:@"%.2f",self.resultModel.result.total];
            return cell;
        }
            case 1:
        {
            GM_ADCell * cell = [tableView dequeueReusableCellWithIdentifier:@"gm_ad"];
            if (!cell) {
                cell = [[GM_ADCell alloc]init];
            }
            cell.adsDataArr = [NSMutableArray arrayWithArray:self.imageArr];
            return cell;
        }
            case 2:
        {
            FM_MYFinacial_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"FM_MYFinacial_Cell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_MYFinacial_Cell" owner:self options:nil]lastObject];
            }
            return cell;
        }
        default:
        {
            FM_productList_cell * cell = [tableView dequeueReusableCellWithIdentifier:@"FM_productList_cell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"FM_productList_cell" owner:self options:nil]lastObject];
            }
            
//            FinacialProductListModel *model = self.mzFincialProductModel.result[indexPath.row];
//            
//            cell.model = model;
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 130;
        case 1:
            return kScreenWidth/4.0;
        case 2:
            return 44;
        default:
            return 68;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 2: // 我的理财
        {
            MY_MoneyManagmentTVC * MY_managerVC = [[MY_MoneyManagmentTVC alloc]initWithStyle:UITableViewStyleGrouped];
//            MY_managerVC.resultModel  = self.resultModel;
            [self.navigationController pushViewController:MY_managerVC animated:YES];
        }
            break;
        case 3: {
            [self sectionThreeWithRow:indexPath.row];
        }
        default:
            break;
    }
}

- (void)sectionThreeWithRow:(NSInteger)row {
    switch (row) {
        case 0: { // 定期理财
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([TermFinancialController class]) bundle:nil];
            TermFinancialController *controller = [storyboard instantiateInitialViewController];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1: { // 活期理财
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([CurrentFinancialController class]) bundle:nil];
            CurrentFinancialController *controller = [storyboard instantiateInitialViewController];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark -----NetRequest ----

@end





