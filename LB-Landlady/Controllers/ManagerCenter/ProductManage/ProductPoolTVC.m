//
//  ProductPoolTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductPoolTVC.h"
#import "ProductPoolCell.h"
#import "ProductPoolModel.h"
#import <UIImageView+WebCache.h>

@interface ProductPoolTVC ()
{
    int _currentPageNum;
}
@property(nonatomic,strong)NSMutableArray * productPoolArr;
@end

@implementation ProductPoolTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title = @"产品仓库";
    self.productPoolArr = [[NSMutableArray alloc]init];
    [self getProductionPoolTableViewDataSource:_currentPageNum];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        FMLog(@"本店仓库列表刷新 footer");
        _currentPageNum ++;
        [self getProductionPoolTableViewDataSource:_currentPageNum];
    }];
    
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

    return self.productPoolArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductPoolCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductPoolCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductPoolCell" owner:self options:nil]lastObject];
    }
    cell.pstatusBtn.tag = indexPath.row;
    cell.productionPoolBtnClickBlock = ^(int btnTag){
        ProductPoolModel * model = self.productPoolArr[btnTag];
        [self updateProductPoolStatus:model
         .product_pool_id withCell:cell];
        
    };
    ProductPoolModel * model = [self.productPoolArr objectAtIndex:indexPath.row];
    [cell.PImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
    cell.PnameLab.text = model.product_pool_name;
    if ([model.price isEqualToString:@""]) {
        cell.pPriceLab.text = @"";
    }else
    {
        cell.pPriceLab.text = [NSString stringWithFormat:@"￥%@%@",model.price,model.unit];
    }
    cell.type = PRODUCTION_TYPE_NONE;
    cell.pCategroyLab.text = model.industry_name;
    cell.pTimeLab.text = model.pool_create_time;
    if (!model.status) {
        cell.pstatusBtn.hidden = YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark ------NetRequest-------
-(void)getProductionPoolTableViewDataSource:(int)currentPageNum
{
    FMLog(@"currentPageNum === %d",currentPageNum);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getProductPoolByBusinessUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:[NSNumber numberWithInt:_currentPageNum] forKey:@"currentPageNum"];
        [param setObject:@10 forKey:@"pageSize"];
        [param setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject====%@====%@",responseObject,responseString);
            NSArray * arr = [NSArray array];
            arr = [ProductPoolModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"productPoolList"]];
            [self.productPoolArr addObjectsFromArray:arr];
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE)
            {
                [self.tableView reloadData];
                [self.tableView.footer endRefreshing];
            }
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error);
        } WithController:self];
    });
}

-(void)updateProductPoolStatus:(NSString *)productPoolId withCell:(ProductPoolCell *)cell
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService updateProductPoolStatus];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:productPoolId forKey:@"productPoolId"];//产品池产品ID
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                cell.pstatusBtn.hidden = YES;
            }
            FMLog(@"responseObject===%@",responseObject);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
@end
