//
//  VIPDetailTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "VIPDetailTVC.h"

@interface VIPDetailTVC ()

@end

@implementation VIPDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员编辑";
    self.vIPIDTF.text = [NSString stringWithFormat:@"%d",_model.associator_id];
    [self.vIPIDTF setValue:@8 forKey:@"limit"];
    self.nickNameTF.text = _model.associator_name;
    [self.nickNameTF setValue:@6 forKey:@"limit"];
    self.phoneTF.text = _model.associator_phone;
    [self.phoneTF setValue:@11 forKey:@"limit"];
    self.vipRandTF.text = [NSString stringWithFormat:@"%d",_model.associator_level];
    [self.vipRandTF setValue:@8 forKey:@"limit"];
    [self initSureButton];
    [self setUpRightItem];
    
}

#pragma mark ------------Private -----------------

-(void)setUpRightItem
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"删除" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBttonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 45, 30);
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
-(void)initSureButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 196, kScreenWidth-40, 40);
    [button setBackgroundColor:LD_COLOR_ONE];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确  认" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark ------ButtonClick------

-(void)rightBttonClick
{
    [self deleteVIP];
}
-(void)sureBtnClick
{
    if (_phoneTF.text) {
        [self editVIP];
    }else
    {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入会员联系方式";
        [hud hide:YES afterDelay:ERROR_DELAY];
    }
}
#pragma mark - 删除 -
-(void)deleteVIP
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService delAssociator];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:[NSNumber numberWithInt:_model.associator_id] forKey:@"id"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"delt=====%@",responseObject);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                if (self.deltSuccessBlock) {
                    _deltSuccessBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

#pragma mark - 编辑会员 -
-(void)editVIP
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService updateAssociator];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:_phoneTF.text forKey:@"phone"];
        [params setObject:[NSNumber numberWithInt:_model.associator_id] forKey:@"id"];
        
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                if (self.successBlock) {
                    self.successBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
