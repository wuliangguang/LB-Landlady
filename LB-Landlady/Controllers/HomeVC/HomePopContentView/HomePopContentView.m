//
//  HomePopContentView.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/9/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomePopContentView.h"

@implementation HomePopContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 订单列表
/*
- (IBAction)orderListButtonClick:(id)sender {
    if (self.orderListHandler) {
        self.orderListHandler();
    }
}

// 订单生成
- (IBAction)orderGenerateButtonClick:(id)sender {
    if (self.orderGenerateHandler) {
        self.orderGenerateHandler();
    }
}
*/

- (void)orderListButtonClick:(id)sender {
    if (self.orderListHandler) {
        self.orderListHandler();
    }
}

// 订单生成
- (void)orderGenerateButtonClick:(id)sender {
    if (self.orderGenerateHandler) {
        self.orderGenerateHandler();
    }
}

+ (instancetype)homePopContentView {
    // 用XIB有问题，此处暂不知为什么，待定
    /**
    HomePopContentView *contentView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    // contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.frame = CGRectMake(20, 20, 100, 300);
    contentView.backgroundColor = ColorA(0, 0, 0, 0.5);
    // [contentView setNeedsDisplay];
    // [contentView layoutSubviews];
    return contentView;
     */
    HomePopContentView *contentView = [[HomePopContentView alloc] initWithFrame:CGRectMake(0, 0, 127, 75)];
    contentView.backgroundColor = ColorA(0, 0, 0, 0.5);
    
    UIButton *buttonUp = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonUp.frame = CGRectMake(14, 9, 99, 22);
    [buttonUp setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 19)];
    [buttonUp setTitleEdgeInsets:UIEdgeInsetsMake(0, 13, 0, 0)];
    buttonUp.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [buttonUp setImage:[[UIImage imageNamed:@"home_order_list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buttonUp setTitle:@"订单列表" forState:UIControlStateNormal];
    [buttonUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonUp addTarget:contentView action:@selector(orderListButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:buttonUp];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 38, 99, 0.6)];
    line.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:line];
    
    UIButton *buttonDown = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonDown.frame = CGRectMake(14, 45, 99, 22);
    [buttonDown setImageEdgeInsets:buttonUp.imageEdgeInsets];
    [buttonDown setTitleEdgeInsets:buttonUp.titleEdgeInsets];
    buttonDown.titleLabel.font = buttonUp.titleLabel.font;
    [buttonDown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonDown setImage:[[UIImage imageNamed:@"home_order_generate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buttonDown setTitle:@"订单生成" forState:UIControlStateNormal];
    [buttonDown addTarget:contentView action:@selector(orderGenerateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:buttonDown];
    
    return contentView;
}

@end
