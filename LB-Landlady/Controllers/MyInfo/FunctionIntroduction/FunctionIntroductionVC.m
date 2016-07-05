//
//  FunctionIntroductionVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "FunctionIntroductionVC.h"
#import "FuctionCell.h"
@interface FunctionIntroductionVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * introductionArr;
@end

@implementation FunctionIntroductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tableview.bounces = NO;
    self.title = @"功能介绍";
    self.tableview.backgroundColor = LD_COLOR_FOURTEEN;
    _titleArr = @[@"经营收入",@"切换商铺",@"店员管理",@"交易管理",@"会员管理",@"财务管理",@"我的资料",@"我的商铺",@"我的消息",@"其他功能"];
    _introductionArr = @[@"可以查看商家的各种类型收入，剖析经营效果",@"针对一个商家可以有多家商铺的情况，可以切换商家的不同商铺",@"商家可以管理自家商铺内的员工，在应用内直接查看员工信息并可以联系员工",@"查看在线交易订单，并可对订单进行管理",@"通过增添会员不同等级的机制，帮助商家黏住客户",@"连通账户资金与银行卡的联系，方便账户资金周转",@"商家的资料自行管理",@"查看自家商铺的资料及对商铺资料的编辑，新增商铺",@"管理商家收到不同消息信息，及时通知商家相应的消息",@"包含意见反馈及退出登录功能"];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FuctionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FuctionCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FuctionCell" owner:self options:nil]lastObject];
    }
    cell.title.text = _titleArr[indexPath.section];
    cell.introduction.text = _introductionArr[indexPath.section];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
