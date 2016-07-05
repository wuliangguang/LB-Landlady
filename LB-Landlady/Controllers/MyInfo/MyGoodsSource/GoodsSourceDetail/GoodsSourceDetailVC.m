//
//  GoodsSourceDetailVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "GoodsSourceDetailVC.h"
#import "GoodsSourceDetailHeaderCell.h"
#import "GoodSourceDetailRateCell.h"
#import "GoodsSourceConfirmViewController.h"
#import "GoodSourceDetailDataModel.h"
#import "CommonModel.h"

@interface GoodsSourceDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) GoodSourceDetailDataModel *dataModel;
@end

@implementation GoodsSourceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"货源详情";
    NSString *name = NSStringFromClass([GoodSourceDetailRateCell class]);
    [self.tableview registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
    
    [self fetchWebData];
}

// 获取货源详情
- (void)fetchWebData {
    [S_R LB_GetWithURLString:[URLService getProductSource] WithParams:@{@"productSourceId" : self.productModel.product_source_id} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"货源详情： %@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[GoodSourceDetailDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            GoodSourceDetailDataModel *dataModel = commonModel.data;
            self.dataModel = dataModel;
            NSLog(@"%@", self.dataModel.businessinfo.data.businessName);
            [self.tableview reloadData];
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

- (void)setDataModel:(GoodSourceDetailDataModel *)dataModel {
    if (_dataModel != dataModel) {
        _dataModel = dataModel;
        _dataModel.priceItemArray = [ProductPriceItem priceItemArrayWithPrice:dataModel.productsrouce.price unit:dataModel.productsrouce.unit];
        if (_dataModel.priceItemArray.count > 0) {
            ProductPriceItem *firstItem = _dataModel.priceItemArray[0];
            firstItem.check = YES;
        }
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 20, kScreenWidth-40, 40);
        [button setBackgroundColor:LD_COLOR_ONE];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"提交订单 "forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 80;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.dataModel.priceItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *identifier = NSStringFromClass([GoodsSourceDetailHeaderCell class]);
        GoodsSourceDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        __weak __typeof(self) weakself = self;
        cell.numDidChangeCallback = ^() {
            // [weakself.tableview reloadData];
            [weakself.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        };
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        }
        cell.dataModel = self.dataModel;
        return cell;
    } else {
        GoodSourceDetailRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodSourceDetailRateCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GoodSourceDetailRateCell class]) owner:nil options:nil] firstObject];
        }
        cell.itemModel = self.dataModel.priceItemArray[indexPath.row];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kScreenWidth/2.0 + 100;
    } else {
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0) {
        for (ProductPriceItem *item in self.dataModel.priceItemArray) {
            item.check = NO;
        }
        ProductPriceItem *item = self.dataModel.priceItemArray[indexPath.row];
        item.check = YES;
    }
    [tableView reloadData];
}

#pragma mark ------ButtonClick------
/**
 *  提交订单
 */
- (void)sureBtnClick {
    GoodsSourceConfirmViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([GoodsSourceConfirmViewController class]) bundle:nil] instantiateInitialViewController];
    controller.dataModel = self.dataModel;
    ProductPriceItem *choosedItem = nil;
    for (ProductPriceItem *item in self.dataModel.priceItemArray) {
        if (item.check == YES) {
            // TODO:// 这个地方最好用copy, 并实现copyWithZone:的通用方法，由于时间关系，暂且写下如此
            choosedItem                       = [[ProductPriceItem alloc] init];
            choosedItem.priceVolume           = item.priceVolume;// 价格
            choosedItem.priceUnit             = item.priceUnit;// 价格单位(元)
            choosedItem.productUnit           = item.productUnit;// 产品单位
            GoodsSourceDetailHeaderCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            choosedItem.productVolume         = [cell inputNum];// 用户输入的数量
            controller.choosedPriceItem       = choosedItem;
            break;
        }
    }
    [self.navigationController pushViewController:controller animated:YES];
}
@end






