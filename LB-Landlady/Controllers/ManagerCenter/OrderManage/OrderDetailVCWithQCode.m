//
//  OrderDetailVCWithQCode.m
//  LB-Landlady
//
//  Created by 露露 on 16/3/9.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OrderDetailVCWithQCode.h"
#import "QRCodeViewController.h"
#import <LianBiLib/CustomQrCode.h>
#import "OrderListTVC.h"
#import "UIViewController+ZZNavigationItem.h"
#import "NotificationHelper.h"

@interface OrderDetailVCWithQCode ()

/**
 * 订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

/**
 * 名字
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

/**
 * 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 * 手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

/**
 * 地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/**
 * 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/**
 * 二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

// 订单列表button
@property (weak, nonatomic) IBOutlet UIButton *orderListButton;

@end

@implementation OrderDetailVCWithQCode

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title                        = @"订单详情";
    _payByQScanBtn.layer.cornerRadius = 3;
    _payByQScanBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
    _payByQScanBtn.layer.borderWidth  = 1;
    _payByQScanBtn.clipsToBounds      = YES;
    _goToOrderListBtn.layer.cornerRadius = 3;
    _goToOrderListBtn.clipsToBounds      = YES;
    
    [self refreshUI];
    
    [self addStandardBackButtonWithClickSelector:@selector(back)];

}

- (void)back
{
    if ([self.fromClass isEqualToString:@"OrderGenerateVC"])
    {
        [NotificationHelper postNotificationOfIncomeChangeWithObject:self userInfo:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)refreshUI
{
    self.addressLabel.text = @"                    ";
    if (_orderModel != nil)
    {
        self.orderIdLabel.text  = [NSString stringWithFormat:@"订单号:%@",_orderModel.order_id];
        self.userNameLabel.text = _orderModel.user_name;
        self.timeLabel.text     = _orderModel.createTime;
        self.phoneLabel.text    = _orderModel.phone;
        self.addressLabel.text  = _orderModel.address;
        if (_orderModel.address == nil) 
        {
            self.addressLabel.text = @"                    ";
        }
        self.priceLabel.text    = _orderModel.price;
        self.qrImageView.image  = [CustomQrCode createQRCodeWithValue:_orderModel.urlCode WithRed:0 Green:0 Blue:0 WithSize:self.qrImageView.bounds.size.width];
    }
}

- (IBAction)payByQScan:(id)sender {
    QRCodeViewController *qrCodeVC      = [[QRCodeViewController alloc] init];
    qrCodeVC.price = self.orderModel.price;
    qrCodeVC.orderId = self.orderModel.order_id;
    self.orderModel.urlCode = @"付款码已失效";
    [self.navigationController pushViewController:qrCodeVC animated:YES];
}

- (IBAction)gotoOrderListVC:(id)sender {
    if ([self.fromClass isEqualToString:@"OrderGenerateVC"])
    {
        OrderListTVC * order = [[OrderListTVC alloc]init];
        order.createType = @"present";
        [self.navigationController pushViewController:order animated:YES];
    }
    else
    {
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
