//
//  NewPsdResultVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/18.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "NewPsdResultVC.h"

@interface NewPsdResultVC ()

@end

@implementation NewPsdResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------btnClick-------
- (IBAction)backToCardVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
