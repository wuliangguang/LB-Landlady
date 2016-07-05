//
//  OrderDetailVCWithQCode.h
//  LB-Landlady
//
//  Created by 露露 on 16/3/9.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListDetailModel.h"

@interface OrderDetailVCWithQCode : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *payByQScanBtn;
@property (strong, nonatomic) IBOutlet UIButton *goToOrderListBtn;
/*
 *返回按钮：记录从什么地方进入这个类，如果是list页，则pop，如果是OrderGenerateVC页，则dismissviewcontroller
 *去列表按钮：如果是从列表进来的，则pop，如果是从OrderGenerateVC页，则push OrderListTVC
 */
@property (nonatomic, strong) NSString          *fromClass;

@property (nonatomic) OrderListDetailModel *orderModel;
@end
