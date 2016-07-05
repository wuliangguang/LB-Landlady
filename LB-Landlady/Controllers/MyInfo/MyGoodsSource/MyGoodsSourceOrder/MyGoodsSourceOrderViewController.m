//
//  MyGoodsSourceOrderViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceOrderViewController.h"
#import "MyGoodsSourceOrderHeadCell.h"
#import "MyGoodsSourceOrderCell.h"
#import "MyGoodsSourceOrderDetailViewController.h"
#import "MJRefresh.h"
#import "CommonModel.h"
#import "GoodSourceOrderDataModel.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface MyGoodsSourceOrderViewController ()

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSInteger currentPageNum;
@end

@implementation MyGoodsSourceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"下单记录";
    self.tableView.sectionFooterHeight = 0;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReresh)];
    self.tableView.footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerReresh)];
    
    [self fetchWebData];
}

//上拉
- (void)footerReresh {
    self.currentPageNum = 0;
    [self fetchWebData];
}

// 下拉
- (void)headerReresh {
    ++self.currentPageNum;
    [self fetchWebData];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)fetchWebData {
    NSLog(@"%@",App_User_Info.myInfo.userModel.defaultBusiness);
    NSDictionary *dict = @{
                           @"businessId" : App_User_Info.myInfo.userModel.defaultBusiness,
                           @"currentPageNum" : [NSString stringWithFormat:@"%ld", self.currentPageNum],
                           @"pageSize" : @"20"
                           };
    [S_R LB_GetWithURLString:[URLService orderProductionSourceList] WithParams:dict WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[GoodSourceOrderDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            [self endRefresh];
            if (self.currentPageNum == 0) {
                [self.dataArray removeAllObjects];
            }
            GoodSourceOrderDataModel *dataModel = commonModel.data;
            [self.dataArray addObjectsFromArray:dataModel.productSourceList];
            [self.tableView reloadData];
        } else {
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            [MBProgressHUD showFailToast:@"请求数据失败" inView:self.view completionHandler:nil];
            [self endRefresh];
        }
        // NSLog(@"%@", responseString);
        [self endRefresh];
    } failure:^(NSError *error) {
        // NSLog(@"%@", error);
        [self endRefresh];
    } WithController:self];
}

- (void)endRefresh {
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodSourceOrderModel *orderModel = self.dataArray[indexPath.row/2];
    if (indexPath.row % 2 == 0) {
        MyGoodsSourceOrderHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyGoodsSourceOrderHeadCell class]) forIndexPath:indexPath];
        cell.orderModel = orderModel;
        return cell;
    } else {
        MyGoodsSourceOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyGoodsSourceOrderCell class]) forIndexPath:indexPath];
        cell.orderModel = orderModel;
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row % 2 == 0 ? 32 : 66;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyGoodsSourceOrderDetailViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyGoodsSourceOrderDetailViewController class]) bundle:nil] instantiateInitialViewController];
    FMLog(@"%ld----%ld-----%ld",(long)indexPath.row,(long)self.dataArray.count,indexPath.row/2);
    if (indexPath.row % 2 != 0) {
        controller.orderModel = self.dataArray[indexPath.row/2];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

@end
