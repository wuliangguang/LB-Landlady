//
//  ForgetPSWTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/18.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "ForgetPSWTableVC.h"
#import "FindPSDTableVC.h"
#import "UIViewController+ZZNavigationItem.h"

@interface ForgetPSWTableVC ()
@property(nonatomic,strong)MBProgressHUD * Mbp;
@property (nonatomic, strong)NSTimer * timer;
@property (strong, nonatomic) IBOutlet UILabel *btLable;
@end

@implementation ForgetPSWTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSureButton];
    [self initNavigation];
    [self.bankNumTF setValue:@19 forKey:@"limit"];
    self.smsBtn.layer.borderWidth = 1;
    
    self.smsBtn.layer.borderColor = Color(255, 60, 37).CGColor;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.smsBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
     _btLable.text = @"发送验证码";
}
-(void)initNavigation
{
    [self addStandardBackButtonWithClickSelector:@selector(backButton)];
}

-(void)initSureButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 44*2+20, kScreenWidth-40, 40);
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark --------btnClick-------
-(void)backButton
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sendSureCode:(id)sender {
    [self.view endEditing:YES];
    if (self.bankNumTF.text.length == 0) {
        _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _Mbp.mode = MBProgressHUDModeText;
        _Mbp.labelText = @"请输入卡号";
        [_Mbp hide:YES afterDelay:2];
    }else
    {
        [self getSureCodeSMSRequest];
    }
    
}
-(void)getSureCodeSMSRequest
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService sendUpdatePasswordCodeUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:App_User_Info.myInfo.userModel.userId  forKey:@"userId"];
        [param setObject:self.bankNumTF.text forKey:@"bankNum"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                _smsBtn.enabled = NO;
                _timeout = 61;
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(initLabelView) userInfo:nil repeats:YES];
            }else
            {
                MBProgressHUD * hud = [MBProgressHUD HUDForView:self.view];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = responseObject[@"msg"];
                [hud hide:YES afterDelay:ERROR_DELAY];
            }
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
-(void)nextBtnClick:(UIButton *)button
{
    [self.view endEditing:YES];
    NSString * mes = nil ;
    if ([self.bankNumTF.text isBlank]) {
        mes = @"请输入绑定的银行卡号";
    }else if([self.bankNumTF.text removeWhiteSpacesFromString].length <16)
    {
        mes = @"请输入正确的银行卡号";
    }
    else if ([self.sureCodeTF.text isBlank])
    {
        mes = @"请输入验证码";
    }
    if (mes) {

        _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _Mbp.mode = MBProgressHUDModeText;
        _Mbp.labelText = mes;
        [_Mbp hide:YES afterDelay:2];
    }else
    {
//        [self backSmsRequest];
        FindPSDTableVC * findVC = [[FindPSDTableVC alloc]init];
        findVC.bankCardNum = self.bankNumTF.text;
        findVC.number = 2015;
        findVC.code = self.sureCodeTF.text;
        [self.navigationController pushViewController:findVC animated:YES];
    }
    
    
}
//60秒倒计时
-(void)initLabelView
{
    _timeout--;
    _btLable.text =[NSString stringWithFormat:@"获取验证码(%ds)",_timeout];
    _smsBtn.titleLabel.tintColor=[UIColor redColor];

    
    if (_timeout==0)
    {
        [_timer invalidate];
        _smsBtn.enabled = YES;
        _btLable.text = @"重新获取";
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark ------NetRequest-------

@end
