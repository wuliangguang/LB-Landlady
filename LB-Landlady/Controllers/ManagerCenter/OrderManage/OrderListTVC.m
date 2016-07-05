//
//  OrderListTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/3/9.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OrderListTVC.h"
#import "TMStatusCell.h"
#import "OrderDetailVCWithQCode.h"
#import "UIViewController+ZZNavigationItem.h"

@interface OrderListTVC ()
@property(nonatomic,strong)NSArray * dataArr;
@end

@implementation OrderListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单列表";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self addStandardBackButtonWithClickSelector:@selector(back:)];
}

- (void)back:(id)sender {
    NSLog(@"back");
    if ([self.createType isEqualToString:@"present"])
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -------tableViewDelegate ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _dataArr.count;
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TMStatusCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TMStatusCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    OrderListModel * model = _modelArr[indexPath.row-1];
//    cell.topLab.text = model.order_id;
//    cell.timeLab.text = model.createTime;
//    cell.moneyLab.text = [NSString stringWithFormat:@"%.1f",[model.price floatValue]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"OrderDetailVCWithQCode" bundle:nil];
    OrderDetailVCWithQCode * VC = [SB instantiateInitialViewController];
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
