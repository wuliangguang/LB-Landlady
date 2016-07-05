//
//  MyGoodsSourceShopViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceShopViewController.h"
#import "MyGoodsSourceShopOptionCell.h"
#import "MyGoodsSourceShopCell.h"
#import "GoodsSourceDetailVC.h"
#import "CommonModel.h"
#import "IndustryDataModel.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "GoodSourceProductDataModel.h"

@interface MyGoodsSourceShopViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  左侧tableView, 行业列表
 */
@property (weak, nonatomic) IBOutlet UITableView *optionTableView;

/**
 *  右侧tableView, 内容列表
 */
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@property (nonatomic) NSArray *industryArray;
@property (nonatomic) NSArray *productArray;
@end

@implementation MyGoodsSourceShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)initUI {
    self.title = @"货源商城";
    [S_R LB_GetWithURLString:[URLService getIndustryListUrl] WithParams:nil WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        CommonModel *model = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IndustryDataModel class]];
        if (model.code == SUCCESS_CODE) {
            IndustryDataModel *dataModel = (IndustryDataModel *)model.data;
            self.industryArray = dataModel.modelList;
            [self.optionTableView reloadData];
            
            [self checkFirst];
        } else {
            [MBProgressHUD showFailToast:@"获取行业列表失败" inView:self.view completionHandler:nil];
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

/**
 *  默认选中第一个
 */
- (void)checkFirst {
    if (self.industryArray) {
        IndustryModel *first = self.industryArray[0];
        first.check = YES;
    }
    UITableViewCell *cell = [self.optionTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell setSelected:YES animated:YES];
    [self tableView:self.optionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.optionTableView) {
        return self.industryArray.count;
    } else {
        return self.productArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.optionTableView) {
        MyGoodsSourceShopOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyGoodsSourceShopOptionCell class]) forIndexPath:indexPath];
        if (self.industryArray) {
            cell.industryModel = self.industryArray[indexPath.row];
        }
        return cell;
    } else  {
        MyGoodsSourceShopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyGoodsSourceShopCell class]) forIndexPath:indexPath];
        GoodSourceProductModel *model = self.productArray[indexPath.row];
        cell.productModel = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.optionTableView) {
        for (IndustryModel *model in self.industryArray) {
            model.check = NO;
        }
        IndustryModel *model = self.industryArray[indexPath.row];
        model.check = YES;
        [tableView reloadData];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        // [cell setSelected:YES animated:NO];
        [cell setHighlighted:YES];
        NSDictionary *dict = @{
                               @"cateId" : model.industryId, // 多个用英文“,”逗号隔开
                               @"currentPageNum" : @"0", // 当前页面数
                               @"pageSize" : @"20" // 获取数据数
                               };
        [S_R LB_GetWithURLString:[URLService getProductSourceListUrl] WithParams:dict WithSuccess:^(id responseObject, id responseString) {
            CommonModel *common = [CommonModel commonModelWithKeyValues:responseObject dataClass:[GoodSourceProductDataModel class]];
            if (common.code == SUCCESS_CODE) {
                GoodSourceProductDataModel *dataModel = common.data;
                self.productArray                     = dataModel.productSourceList;
                NSLog(@"--%@--%@",self.productArray,dataModel);
                [self.contentTableView reloadData];
            }
        } failure:^(NSError *error) {
            // NSLog(@"%@", error);
        } WithController:self];
    } else {
        UIStoryboard * SB = [UIStoryboard storyboardWithName:@"GoodsSourceDetailVC" bundle:nil];
        GoodsSourceDetailVC *goodsDetailVC = [SB instantiateInitialViewController];
        GoodSourceProductModel *model = self.productArray[indexPath.row];
        goodsDetailVC.productModel    = model;
        goodsDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

@end
