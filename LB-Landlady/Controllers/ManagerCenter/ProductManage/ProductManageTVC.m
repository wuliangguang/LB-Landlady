//
//  ProductManageTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductManageTVC.h"

@interface ProductManageTVC ()

@end

@implementation ProductManageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品管理";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
