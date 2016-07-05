//
//  BindResultViewController.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/27.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "BindResultViewController.h"

@interface BindResultViewController ()

@end

@implementation BindResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"selectedBtn"] == 1101) {
        self.switchLabel.text = @"将自动返回至银行卡页面....";
    }else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"selectedBtn"] == 1100)
    {
        self.switchLabel.text = @"将自动返回至提现页面....";
    }else
    {
        self.switchLabel.text = @"将自动返回至老板娘首页....";
    }
    
    if ([self.resultType integerValue] == 0) {
        [self success];
    }else{
        [self fail];
    }
    // Do any additional setup after loading the view.
}
#pragma mark ------ private ----
-(void)success{
    self.title = @"绑定成功";
    self.resultImageView.image = [UIImage imageNamed:@"complete"];
    self.resultLabel.text = @"银行卡绑定成功";
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setBool:YES forKey:@"isBind"];
//    [ud synchronize];
    [self performSelector:@selector(goBack) withObject:nil afterDelay:1.5];
}
-(void)goBack{
//   [self dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"dismiss");
    }];
   // [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)fail{
    self.title = @"绑定失败";
    self.resultImageView.image = [UIImage imageNamed:@"failure"];
    self.resultLabel.text = @"银行卡绑定失败";
    [self performSelector:@selector(goBack) withObject:nil afterDelay:1.5];
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
