//
//  OurStoreTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/15.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OurStoreTVC.h"
#import "ProductPoolCell.h"
#import "WebVC.h"
#import "OurStoreModel.h"
#import <UIImageView+WebCache.h>


@interface OurStoreTVC ()

@property(nonatomic,strong)NSMutableArray * productArr;
@end

@implementation OurStoreTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本店产品";
    self.productArr= [[NSMutableArray alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self setUpRightItem];
    [self getProductList];
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
//    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        FMLog(@"本店产品列表刷新 footer");
//    }];
    
}
-(void)setUpRightItem
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addProductionBttonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 45, 30);
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
-(void)addProductionBttonClick
{
    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"WebVC" bundle:nil];
    WebVC * webVC = [SB instantiateInitialViewController];
    webVC.addBlock = ^{
        [self getProductList];
    };
    webVC.urlString = [URLService getCommitProductUrl];
    [self.navigationController pushViewController:webVC animated:YES];
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
    return self.productArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductPoolCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductPoolCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductPoolCell" owner:self options:nil]lastObject];
    }
    OurStoreModel * model = [self.productArr objectAtIndex:indexPath.row];
    [cell.PImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
    cell.PnameLab.text = model.product_name;
    if ([model.price isEqualToString:@""]) {
        cell.pPriceLab.text = @"";
    }else
    {
        cell.pPriceLab.text = [NSString stringWithFormat:@"￥%@%@",model.price,model.unit];
    }
    
    cell.type = [model.product_type integerValue];
    cell.pCategroyLab.text = model.industry_name;
    cell.pTimeLab.text = model.start_date;
    cell.pstatusBtn.hidden = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FMLog(@"删除本店产品");
        OurStoreModel * model = self.productArr[indexPath.row];
        [self deleteProductionNet:model.product_id];
    }
}
-(NSString * )tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark ------NetRequest-------

-(void)getProductList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getProductList];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:App_User_Info.myInfo.userModel.defaultBusiness  forKey:@"businessId"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            self.productArr = [OurStoreModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"product"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
-(void)deleteProductionNet:(NSString *)productID
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getDelProductSourceUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:productID  forKey:@"productSourceId"];//货源ID
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                [self getProductList];
            }
            
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}

@end
