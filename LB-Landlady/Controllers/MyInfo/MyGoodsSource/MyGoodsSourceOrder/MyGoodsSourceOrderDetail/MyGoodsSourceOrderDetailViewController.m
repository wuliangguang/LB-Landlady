//
//  MyGoodsSourceOrderDetailViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceOrderDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NSString+Helper.h"

@interface MyGoodsSourceOrderDetailViewController ()

/**
 *  商铺名字
 */
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;

/**
 *  订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

/**
 *  businessName
 */
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;

/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

/**
 *  商品图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

/**
 *  价钱总额
 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation MyGoodsSourceOrderDetailViewController

- (void)setOrderModel:(GoodSourceOrderModel *)orderModel {
    if (_orderModel != orderModel) {
        _orderModel = orderModel;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"订单详细信息";
    self.tableView.sectionFooterHeight = 0;
    
    self.merchantNameLabel.text = _orderModel.business_name;
    self.orderLabel.text        = _orderModel.product_id;
    self.businessNameLabel.text = _orderModel.business_name;
    self.addressLabel.text      = _orderModel.address;
    self.phoneLabel.text        = _orderModel.phone;
    self.productNameLabel.text  = _orderModel.product_source_title;
    self.numLabel.text          = [NSString stringWithFormat:@"x%ld", _orderModel.num];
    self.moneyLabel.text        = [NSString stringWithFormat:@"￥%.2f", _orderModel.price];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_orderModel.image] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
}

/** 联系卖家 */
- (IBAction)contact:(id)sender {
    NSLog(@"TODO:// 联系卖家");
    [self.orderModel.vendorPhone phoneCall];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

@end
