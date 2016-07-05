//
//  BankCardViewController.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/27.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "BankCardViewController.h"
#import "AddCardViewController.h"
/*
 填写个人资料提交完成时出现的询问是否添加银行卡
 */
@interface BankCardViewController ()

@end

@implementation BankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交成功";
    self.view.backgroundColor = Color(237, 237, 237);
    [self initNavigation];

    [self baseSetting];
    
    // Do any additional setup after loading the view.
}

#pragma mark ----baseSetting ----
-(void)initNavigation{
//    ADD_STANDARD_BACK_NAV_BUTTON;
}

-(void)baseSetting{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, kScreenWidth, 18)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"绑定银行卡可以资金提现";
    label.textColor = [HEXColor getColor:@"#CCCCCC"];
    label.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    UILabel * subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, 18)];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.text = @"是否现在绑定？";
    subLabel.textColor = [HEXColor getColor:@"#CCCCCC"];
    subLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:subLabel];
    
    UIButton * bindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bindButton.frame = CGRectMake(22, 93, kScreenWidth-44, 45);
    
    [bindButton setTitle:@"绑定" forState:UIControlStateNormal];
    [bindButton setBackgroundImage:[UIImage imageNamed:@"blueButton"] forState:UIControlStateNormal];
    bindButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [bindButton addTarget:self action:@selector(bindButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindButton];
}

-(void)bindButtonClick
{

    [self performSegueWithIdentifier:@"addBankCard" sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
