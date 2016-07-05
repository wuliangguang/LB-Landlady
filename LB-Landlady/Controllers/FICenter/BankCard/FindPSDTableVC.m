//
//  FindPSDTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/17.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "FindPSDTableVC.h"
#import "UIViewController+ZZNavigationItem.h"
#import "NewPsdResultVC.h"


@interface FindPSDTableVC ()
@property(nonatomic,strong)NSArray * NameArr;/**<cell的titlt数组*/
@property(nonatomic,strong)NSString * passWord;/**<原密码*/
@property(nonatomic,strong)NSString * nowPassWord;/**<新密码*/
@property(nonatomic,strong)NSString * sureNowPassWord;/**<确认新密码*/
@end

@implementation FindPSDTableVC
#pragma mark ------VC Life CYC 生命周期-----
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    switch (self.number) {
        case 400:
            self.title = @"修改密码";
            self.NameArr = @[@"原交易密码",@"新交易密码",@"确认新密码"];
            break;
            
        default:
            self.title = @"设置新密码";
            self.NameArr =@[@"新交易密码",@"确认新密码"];
            break;
    }
    self.tableView.backgroundColor =Color(237, 237, 237);
    self.tableView.rowHeight = 90;
    
    [self initSureButton];
    [self initNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----- init初始化 -----
-(void)initNavigation
{
    [self addStandardBackButtonWithClickSelector:@selector(backButton)];
}

-(void)initSureButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 90*self.NameArr.count+20, kScreenWidth-40, 40);
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark --------btnClick-------
-(void)sureBtnClick:(UIButton *)button
{
    [self.view endEditing:YES];
    NSString * mes = nil ;
    if (self.number == 400) {
        if (self.passWord==nil||self.nowPassWord == nil ||self.sureNowPassWord == nil) {
            mes = @"请输入新旧密码";
        }else if ([self.passWord isBlank])
        {
            mes = @"请输入原交易密码";
        }else if ([self.nowPassWord isBlank])
        {
            mes = @"请输入新交易密码";
        }else if (self.passWord.length != 6&&self.nowPassWord.length != 6)
        {
            mes = @"请设置六位数提现密码" ;
        }else if (![self.nowPassWord isEqualToString:self.sureNowPassWord])
        {
            mes = @"两次输入的密码不一致";
        }else {
            NSArray *arr = @[@"000000",@"111111",@"222222",@"333333",@"444444",@"555555",@"666666",@"777777",@"888888",@"999999",@"012345",@"123456",@"234567",@"345678",@"456789",@"543210",@"654321",@"765432",@"876543",@"987654"];
            for (NSString *str in arr)
            {
                if ([str isEqualToString:self.nowPassWord])
                {
                    mes = @"新密码过于简单";
                }
            }
        }
        if (mes) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:mes delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }else
        {
            [self changePsdNetRequestForChange];//密码设置成功，添加提现密码
        }
    }else
    {
        if ([self.nowPassWord isBlank])
        {
            mes = @"请输入新交易密码";
        }else if (self.passWord.length != 6&&self.nowPassWord.length != 6)
        {
            mes = @"请设置六位数提现密码" ;
        }else if (![self.nowPassWord isEqualToString:self.sureNowPassWord])
        {
            mes = @"两次输入的密码不一致";
        }else {
            NSArray *arr = @[@"000000",@"111111",@"222222",@"333333",@"444444",@"555555",@"666666",@"777777",@"888888",@"999999",@"012345",@"123456",@"234567",@"345678",@"456789",@"543210",@"654321",@"765432",@"876543",@"987654"];
            for (NSString *str in arr)
            {
                if ([str isEqualToString:self.nowPassWord])
                {
                    mes = @"新密码过于简单";
                }
            }
        }
        if (mes) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:mes delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }else
        {
            [self changePsdNetRequestForForget];//密码设置成功，添加提现密码
        }
    }
}
-(void)backButton
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -----网络 ----
-(void)changePsdNetRequestForChange//修改密码
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService updateBankPasswordUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [params setObject:[NSString stringWithFormat:@"%@",self.bankCardID] forKey:@"bankId"];
        [params setObject:self.passWord forKey:@"password"];
        [params setObject:self.nowPassWord forKey:@"rePassword"];
        FMLog(@"%@-%@-%@-%@",App_User_Info.myInfo.userModel.userId,
              self.bankCardNum,self.passWord ,self.nowPassWord);
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {

            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                UIStoryboard * sb = [UIStoryboard storyboardWithName:@"FindPSD" bundle:nil];
                NewPsdResultVC * resultVC = [sb instantiateInitialViewController];
                [self.navigationController pushViewController:resultVC animated:YES];
            }
            
            FMLog(@"responseObject == %@",responseObject);
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
-(void)changePsdNetRequestForForget//忘记密码
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService forgetPasswordUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [params setObject:self.bankCardNum forKey:@"bankNum"];
        [params setObject:self.code forKey:@"code"];
        [params setObject:self.nowPassWord forKey:@"password"];
        [params setObject:self.sureNowPassWord forKey:@"repassword"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
#warning 符合条件跳转
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"FindPSD" bundle:nil];
            NewPsdResultVC * resultVC = [sb instantiateInitialViewController];
            [self.navigationController pushViewController:resultVC animated:YES];
        } failure:^(NSError *error) {
            
        } WithController:self];
    });

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.number == 400) {//修改
        return 3;
    }else
    {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindPsdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"find"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FindPsdCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tilteLab.text = self.NameArr[indexPath.row];
//    if (self.number ==400)
//    {
//        if (indexPath.row==0)
//        {
//            cell.callbackPsdStr = ^(NSString * password){
//                self.passWord = password;
//            };
//        }else if (indexPath.row ==1)
//        {
//            cell.callbackPsdStr = ^(NSString * newpassword){
//                self.nowPassWord = newpassword;
//            };
//        }
        if (self.number ==400)
        {
            if (indexPath.row ==2)
            {
                cell.psd = ^(NSString *passw) {
                    self.sureNowPassWord = passw;
                
                };
            }
            if (indexPath.row ==0) {
                cell.psd = ^(NSString * password){
                        self.passWord = password;
                    };
             
            }
            if (indexPath.row ==1) {
                self.nowPassWord = cell.topTextField.text;
//                if (cell.psd) {
                    cell.psd = ^(NSString * password){
                        self.nowPassWord = password;
                    };
               // }
            }

        }else
        {
            if (indexPath.row ==0) {
                cell.psd = ^(NSString * password){
                    self.nowPassWord = password;
                };
                
            }
            if (indexPath.row ==1) {
                cell.psd = ^(NSString * password){
                    self.sureNowPassWord = password;
                };
            }
        }

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
