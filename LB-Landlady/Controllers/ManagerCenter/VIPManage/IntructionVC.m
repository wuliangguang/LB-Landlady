//
//  IntructionVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/21.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "IntructionVC.h"

@interface IntructionVC ()

@end

@implementation IntructionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员说明";
    self.introductLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
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
