//
//  OrderQueryCell.m
//  ZBL
//
//  Created by 张伯林 on 16/3/31.
//  Copyright © 2016年 张伯林. All rights reserved.
//

#import "OrderQueryCell.h"
#import "UITableViewCell+ZZAddLine.h"
@implementation OrderQueryCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewScrollPositionNone;
    self.showCustomLine = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showAndUpdateModel:(OrserQueryModel *)model{
    if (model.orderId.length > 20) {
        self.OrderIdLabel.text = [NSString stringWithFormat:@"订单号:%@",[model.orderId substringWithRange:NSMakeRange(0, 20)]];
    }else{
        self.OrderIdLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderId];
    }
    
    //self.OrderIdLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderId];
    
    if([model.payType isEqualToString:@"wechat"]){
        self.zhuFuFangShiLabel.text = @"微信支付";
    }else if([model.payType isEqualToString:@"alipay"]){
        self.zhuFuFangShiLabel.text = @"支付宝支付";
    }else if ([model.payType isEqualToString:@"sweep"]){
     self.zhuFuFangShiLabel.text = @"扫码支付";
    }else if ([model.payType isEqualToString:@"pos"]){
        self.zhuFuFangShiLabel.text = @"pos机支付";
    }else if ([model.payType isEqualToString:@"cash"]){
        self.zhuFuFangShiLabel.text = @"现金支付";
    }else if ([model.payType isEqualToString:@"other"]){
        self.zhuFuFangShiLabel.text = @"其他支付方式";
    }
    if ([model.status isEqualToString:@"success"]) {
        self.zhifuIdeaLabel.text = @"支付成功";
    }else if ([model.status isEqualToString:@"fail"]){
        self.zhifuIdeaLabel.text = @"支付失败";
    }else if([model.status isEqualToString:@"prepare"] || [model.status isEqualToString:@"send"]){
        self.zhifuIdeaLabel.text = @"未支付";
    }else if([model.status isEqualToString:@"unknown"]){
        self.zhifuIdeaLabel.text = @"未知状态";
    }
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"%.2lf元",((double)model.payAmt)/100];
    
   
    if (model.payTime.length == 14) {
        NSString *yearStr = [model.payTime substringWithRange:NSMakeRange(0, 4)];
        NSString *monthStr = [model.payTime substringWithRange:NSMakeRange(4, 2)];
        NSString *dayStr = [model.payTime substringWithRange:NSMakeRange(6, 2)];
        NSString *hoursStr = [model.payTime substringWithRange:NSMakeRange(8, 2)];
        NSString *minutesStr = [model.payTime substringWithRange:NSMakeRange(10, 2)];
        NSString *secondsStr = [model.payTime substringWithRange:NSMakeRange(12, 2)];
        NSString *time = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",yearStr,monthStr,dayStr,hoursStr,minutesStr,secondsStr];
        self.orderTimeLabel.text = time;
    }else{
      
        self.orderTimeLabel.text = model.payTime;
    }
    
    
}
@end
