//
//  PayTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/17.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "PayTableVC.h"
#import <UIImageView+WebCache.h>
//#import "BindMesModel.h"


@interface PayTableVC ()
@property(nonatomic,strong)NSArray * dataArr;
@end

@implementation PayTableVC
#pragma mark ------VC Life CYC 生命周期-----
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    [self initPayButton];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----- init初始化 -----
-(void)initPayButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 205, kScreenWidth-40, 40);
    [button setBackgroundColor:Color(255, 38, 37)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确认充值" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark --------btnClick-------
-(void)saveBtnClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    
#warning 确认充值
    
}
#pragma mark -----TableViewDelegate -----
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        [_moneyTF becomeFirstResponder];
    }
}
#pragma mark ------页面基本数据----
-(void)baseDataSetting{
//    BindMesModel *model = [self.dataArr lastObject];
//    [self.headerIMGView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"bank_default"]];
//    self.nameLAB.text = model.bankname;
//    
//    NSString * accountStr = model.banknum;
//    if ( accountStr.length>9) {
//        NSString *str = [model.banknum substringToIndex:4];
//        NSString *str1 = [model.banknum substringFromIndex:model.banknum.length -4];
//        accountStr = [NSString stringWithFormat:@"%@ **** **** %@",str,str1];
//        
//    }
//    self.accountLab.text = accountStr;
}

@end
