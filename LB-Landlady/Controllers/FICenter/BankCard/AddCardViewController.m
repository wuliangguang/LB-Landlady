//
//  AddCardViewController.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/27.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "AddCardViewController.h"
#import "UIViewController+ZZNavigationItem.h"

@interface AddCardViewController ()

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.name;
    self.view.backgroundColor = Color(237, 237, 237);
    [self addBankButtonSetting];
    [self initNavigation];
}

#pragma mark ----baseSetting ----
-(void)initNavigation{
    [self addStandardBackButtonWithClickSelector:@selector(backButtonClick)];
}

-(void)addBankButtonSetting{
    if (self.name)
    {
        UIButton * addBankCardButton                = [UIButton buttonWithType:UIButtonTypeCustom];
        addBankCardButton.frame                     = CGRectMake(25, 50, kScreenWidth-44, 45);
        [addBankCardButton setBackgroundImage:[UIImage imageNamed:@"xuxiankuang"] forState:UIControlStateNormal];
        [addBankCardButton setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
        addBankCardButton.showsTouchWhenHighlighted = YES;
        [addBankCardButton setTitle:@"点击添加银行卡" forState:UIControlStateNormal];
        [addBankCardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [addBankCardButton addTarget:self action:@selector(addBankCardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addBankCardButton];
    }
    else {
        UIImageView * image                         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pity"]];
        image.frame                                 = CGRectMake((kScreenWidth - 50)/2.0, 22, 50, 50);
        [self.view addSubview:image];
        UILabel * label                             = [[UILabel alloc]initWithFrame:CGRectMake(22, 82, kScreenWidth-44, 15)];
        label.text                                  = @"还没有绑定银行卡，无法提现....";
        label.textAlignment                         = NSTextAlignmentCenter;
        label.font                                  = [UIFont systemFontOfSize:15];
        label.textColor                             = [HEXColor getColor:@"#CCCCCC"];
        [self.view addSubview:label];
        UIButton * addBankCardButton                = [UIButton buttonWithType:UIButtonTypeCustom];
        addBankCardButton.frame                     = CGRectMake(25, 110, kScreenWidth-44, 45);
        [addBankCardButton setBackgroundImage:[UIImage imageNamed:@"xuxiankuang"] forState:UIControlStateNormal];
        [addBankCardButton setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
        addBankCardButton.showsTouchWhenHighlighted = YES;
        [addBankCardButton setTitle:@"点击添加银行卡" forState:UIControlStateNormal];
        [addBankCardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [addBankCardButton addTarget:self action:@selector(addBankCardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addBankCardButton];
    }
   
}

#pragma mark ------ButtonClick------
-(void)addBankCardButtonClick
{
    [self performSegueWithIdentifier:@"cardInfo" sender:nil];
}
-(void)backButtonClick{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"selectedBtn"];
    [ud synchronize];
    [self dismissViewControllerAnimated:NO completion:nil];
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
