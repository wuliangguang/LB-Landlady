//
//  VIPMakeTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "VIPMakeTVC.h"
#import "EditVIPMakeTVC.h"
#import "IntructionVC.h"
#import "VIPListCell.h"
#import "VipModel.h"
#import "VIPDetailTVC.h"


@interface VIPMakeTVC ()
@property(nonatomic,strong)NSMutableArray * levelListArr;
@property(nonatomic,assign)BOOL ischang;
@end

@implementation VIPMakeTVC


#pragma mark ************************** VC LifeCycle **************************
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员制定";
    self.levelListArr = [[NSMutableArray alloc]init];
    self.ischang = YES;
    [self setUpRightItem];
    [self getAllVipLevels];
}


-(void)setUpRightItem
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"说明" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBttonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 45, 30);
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
#pragma mark -------tableViewDelegate ------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIPListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"VIPListCell" owner:self options:nil]lastObject];
    }
    //这个判断不要改（lu）
    if (self.levelListArr.count > 0) {
//        if (indexPath.row<= self.levelListArr.count) {
//            if (indexPath.row != 0) {
                VipModel * model = self.levelListArr[indexPath.row];
                cell.vipLevelName.text = model.b_level_name;
//            }
//        }
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"edit" sender:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * index = sender;
    EditVIPMakeTVC * editTVC = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"edit"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
        if (index.row == 0) {
            
            editTVC.vipRateTF.userInteractionEnabled = NO;
            editTVC.privilgeTF.userInteractionEnabled = NO;
            editTVC.needCostTf.userInteractionEnabled = NO;
            editTVC.isChange = self.ischang;
            
            
        }else
        {
            editTVC.vipRateTF.userInteractionEnabled = YES;
            editTVC.privilgeTF.userInteractionEnabled = YES;
            editTVC.needCostTf.userInteractionEnabled = YES;
        }
            editTVC.model = self.levelListArr[index.row];
            editTVC.defaultModel = self.levelListArr[0];
            editTVC.index = index.row;
            editTVC.editSuccess = ^{
                [self getAllVipLevels];
            };
            editTVC.introduceTFView.placeholder = @"请输入会员其他权益及规则概述";
        });
    }
}

#pragma mark ------ButtonClick------
-(void)rightBttonClick
{
    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"IntructionVC" bundle:nil];
    IntructionVC * VC = [SB instantiateInitialViewController];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ------NetRequest-------
- (void)getAllVipLevels
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getAssociatorLevelListUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:App_User_Info.myInfo.userModel.defaultBusiness  forKey:@"businessId"];
        FMLog(@"%@",App_User_Info.myInfo.userModel.defaultBusiness);
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            self.levelListArr = [VipModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"associatorLevelList"]];
            for (int i=0; i<_levelListArr.count; i++) {
                if (i != 0) {
                    VipModel * model = _levelListArr[i];
                    if (model.status == 1) {
                        self.ischang = NO;
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
