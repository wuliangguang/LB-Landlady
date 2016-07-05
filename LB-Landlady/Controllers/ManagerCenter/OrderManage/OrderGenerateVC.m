//
//  OrderGenerateVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/3/9.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OrderGenerateVC.h"
#import <LianBiLib/CustomQrCode.h>
#import "OrderDetailVCWithQCode.h" // 订单详情
#import "UIViewController+ZZNavigationItem.h"
#import "NSString+Helper.h"
#import "NSString+Helper.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "QRCodeViewController.h"
#import "ZZShowMessage.h"
#import "NotificationHelper.h"

@interface OrderGenerateVC () <UITextFieldDelegate>

@end

@implementation OrderGenerateVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单生成";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.amountTF.delegate = self;

    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_amountTF];
    
    [self addStandardBackButtonWithClickSelector:@selector(back:)];
}

-(void)dealloc
{
    // [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *str = [textField.text stringByAppendingString:string];
    if ([str isEqualToString:@"."]) {
        textField.text = @"0.";
        return NO;
    }
    return [str validPrice];
}

// 刷卡支付
- (IBAction)payByQR:(id)sender {
    NSLog(@"-------------------------");
    NSString *input = [self verifyInputData];
    if (input.length > 0) {
        QRCodeViewController *qrCodeVC      = [[QRCodeViewController alloc] init];
        qrCodeVC.price = input;
        qrCodeVC.orderId = @"1";
        [self.navigationController pushViewController:qrCodeVC animated:YES];
    }
}

- (void)back:(id)sender {
    // 发送通知，总收入发生变化
    [NotificationHelper postNotificationOfIncomeChangeWithObject:self userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitButtonCLick:(id)sender
{
    NSLog(@"-----+++++++++++++++------");
    NSString *input = [self verifyInputData];
    if (input) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSString * urlStr = [URLService getPaymentSweepPayUrl];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            [params setObject:input forKey:@"amount"];
            [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
            [params setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
            NSLog(@"%@", [params mj_JSONString]);
            [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
                NSLog(@"-----------%@",responseObject);
                if ([responseObject[@"code"] integerValue] == SUCCESS_CODE)
                {
                    NSString *str = [self.amountTF.text removeWhiteSpacesFromString];
                    if (str.length <= 0)
                    {
                        NSLog(@"input error");
                        return;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        OrderListDetailModel *orderModel = [[OrderListDetailModel alloc] init];
                        orderModel.urlCode = responseObject[@"data"][@"urlCode"];
                        orderModel.price = str;
                        orderModel.order_id = responseObject[@"data"][@"orderId"];
                        OrderDetailVCWithQCode *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([OrderDetailVCWithQCode class]) bundle:nil] instantiateInitialViewController];
                        controller.orderModel = orderModel;
                        controller.fromClass = @"OrderGenerateVC";
                        [self.navigationController pushViewController:controller animated:YES];
                    });
                }
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            } WithController:self];
        });
    }
}

// 验证用户输入
- (NSString *)verifyInputData {
    NSString *input = [self.amountTF.text removeWhiteSpacesFromString];
    if (input.length <= 0) {
        [MBProgressHUD showFailToast:@"请输入订单信息" inView:self.view completionHandler:nil];
        return nil;
    }
    
    // xxx. 删除.
    NSRange range = NSMakeRange(input.length - 1, 1);
    NSString *last = [input substringWithRange:range];
    if ([last isEqualToString:@"."]) {
        input = [input substringToIndex:range.location];
    }
    return input;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


/**
 - (void)textFieldDidChange:(NSNotification *)obj
 {
 UITextField *textField = (UITextField *)obj.object;
 NSString *toBeString = textField.text;
 //小于10000，保留小数点后面2位
 NSRange templeRange = [toBeString rangeOfString:@"."];//价格判断参数
 //浮点数处理逻辑
 if (templeRange.location != NSNotFound)
 {
 //数字首页为.开头，自动补0
 if ([toBeString hasPrefix:@"."])
 {
 textField.text = [NSString stringWithFormat:@"0%@",toBeString];
 return;
 }
 //小数点后面大于2位，自动截取前2位
 if (toBeString.length > templeRange.location + 3)
 {
 textField.text = [toBeString substringToIndex:templeRange.location + 3];
 return;
 }
 else
 {
 //合理数字
 textField.text = toBeString;
 return;
 }
 }
 else//整数处理逻辑
 {
 //大于9999，截取前4位
 if ([toBeString floatValue] > 9999)
 {
 textField.text = [toBeString substringToIndex:4];
 return;
 }
 //以0开头，自动丢弃
 if ([textField.text hasPrefix:@"0"])
 {
 textField.text = nil;
 return;
 }
 else
 {
 //正常逻辑
 textField.text = toBeString;
 return;
 }
 }
 }*/

@end
