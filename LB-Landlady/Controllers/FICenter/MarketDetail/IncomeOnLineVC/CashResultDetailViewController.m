//
//  CashResultDetailViewController.m
//  MeZoneB_Bate
//
//  Created by 喻晓彬 on 15/10/29.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "CashResultDetailViewController.h"

@interface CashResultDetailViewController ()

@end

@implementation CashResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现结果";
     self.view.backgroundColor = Color(237, 237, 237);
    UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2- 25, 50, 50, 50)];
    iamgeView.image =[UIImage imageNamed:@"complete"];
    [self.view addSubview:iamgeView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 100, 110, 200, 40)];
    label.numberOfLines = 0;
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text  = @"提现已受理\n3至5个工作日后转账成功";
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view.
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
