//
//  AboutUsVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, self.view.frame.size.height-74)];
    imageView.image = [UIImage imageNamed: @"abouus"];
    [self.view addSubview:imageView];
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
