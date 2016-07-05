//
//  VIPManageTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "VIPManageTVC.h"

@interface VIPManageTVC ()

@end

@implementation VIPManageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员管理";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


@end
