//
//  BankViewController.m
//  MeZoneB_Bate
//
//  Created by 喻晓彬 on 15/10/28.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "BankViewController.h"
#import "CashCardCell.h"
#import "BindMesModel.h"
#import <UIImageView+WebCache.h>
#import "ChangeCashResultVC.h"
#import "AddCardViewController.h"
#import "FindPSDTableVC.h"
#import "ForgetPSWTableVC.h"
#import "UIViewController+ZZNavigationItem.h"


@interface BankViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
//    UIView * bottomView;
    UIView * buttonView;
}
@property (nonatomic,strong)UITableView *tabelView;

@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)MBProgressHUD * Mbp;
@property(nonatomic,strong)NSString * password;
@property(nonatomic,strong)NSString * bankNum;
@property(nonatomic,strong)NSNumber * bankID;
@end

@implementation BankViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isBind) {
         [self downLoadDataFromURL];//拉取已绑定的银行卡的基本信息
    }else {
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"selectedBtn"] == 0) {
            if (self.dataArr.count ==0) {
                [self addBankButtonSetting];
            }
            
        } else {
           [self downLoadDataFromURL];
        }
    }
}

- (void)downLoadDataFromURL {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService getBankListUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (App_User_Info.myInfo.userModel.userId)
        {
            [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        }
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                self.dataArr = [BindMesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"bankList"]];
                UIView *view= (UIView *)[self.view viewWithTag:134];
                if (self.dataArr.count != 0) {
                    [view removeFromSuperview];
                    buttonView.hidden = NO;
                }
                [self.tabelView reloadData];
                
            }else {
                self.dataArr = @[];
                [self.tabelView reloadData];
            }

        } failure:^(NSError *error) {
            
        } WithController:self];
        
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"编辑银行卡";
    [self creatTableView];
    [self initNavigation];
    self.view.backgroundColor = Color(237, 237, 237);
    [self initBottomButton];
}
#pragma mark ----- init初始化 -----
-(void)initBottomButton {
    buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-85, kScreenWidth, 85)];
    [self.tabelView addSubview:buttonView];
    UILabel * Hlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    Hlabel.backgroundColor = [HEXColor getColor:@"#e8e8e8"];
    [buttonView addSubview:Hlabel];
    
    NSArray * titleArr = @[@"changeBtn",@"forgetBtn",@"deleteBank"];
    for (int i=0; i<3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        UILabel * lab ;
        if (i==2) {
            button.frame = CGRectMake((kScreenWidth/3.0)*i, 1, kScreenWidth/3.0, 40);
        } else {
            button.frame = CGRectMake((kScreenWidth/3.0)*i, 1, kScreenWidth/3.0-1, 40);
            lab =[[UILabel alloc]initWithFrame:CGRectMake((i+1)*(kScreenWidth/3.0-1)+i, 1, 1, 40)];
        }
        lab.backgroundColor = [HEXColor getColor:@"#e8e8e8"];
        [button setBackgroundColor:Color(247, 247, 247)];
        [button setImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
        button.tag = 400+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
        [buttonView addSubview:lab];
    }
}

- (void)initNavigation {
    [self addStandardBackButtonWithClickSelector:@selector(backButtonClick)];
}

- (void)creatTableView
{
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tabelView.delegate =self;
    self.tabelView.dataSource =self;
    self.tabelView.scrollEnabled = NO;
    self.tabelView.backgroundColor = [UIColor clearColor];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabelView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"CashCardCellId";
    CashCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CashCardCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BindMesModel *model = self.dataArr[indexPath.row];
    self.bankID = model.bankid;
    self.bankNum = model.banknum;
    [cell.bankImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"bank_default"]];
    cell.nameLabel.text = [self replaceUnicode:model.bankname];

    if (model.banknum.length >9) {
        NSString *str = [model.banknum substringToIndex:4];
        NSString *str1 = [model.banknum substringFromIndex:model.banknum.length -4];
        cell.accountLabel.text = [NSString stringWithFormat:@"%@ **** **** %@",str,str1];

    }
    
    
    
    return cell;

}
- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.view endEditing:YES];
    if (alertView.tag == 300)
    {
        if (buttonIndex == 1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            FindPsdCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FindPsdCell" owner:self options:nil] lastObject];
            cell.frame = CGRectMake(10, 30, kScreenWidth-50, (kScreenWidth-50)*128/407.0+20);
            cell.backgroundColor = [UIColor clearColor];
            cell.tilteLab.text = @"交易密码";
            [alert setValue:cell forKey:@"accessoryView"];
            alert.tag = 301;
            cell.psd = ^(NSString * password){
                self.password = password;
            };
            [alert show];
        }
    } else if (alertView.tag == 301){
        if (buttonIndex == 1) {
            if (_password.length  != 6) {
                _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _Mbp.mode = MBProgressHUDModeText;
                _Mbp.labelText = @"请输入6位密码";
                [_Mbp hide:YES afterDelay:2];
            }else {
                [self deleteDateUrl:_password];
            }
        }
    }
}

- (void)deleteDateUrl:(NSString *)pwd {
    /**
     *  *	@param  userId		string		用户ID
     *	@param 	bankID		string  卡号
     *	@param 	password	string  密码
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *pathStr = [URLService delBankUrl];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (App_User_Info.myInfo.userModel.userId)
        {
            [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        }
        [params setObject:pwd forKey:@"password"];
        [params setObject:self.bankID forKey:@"bankId"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"delBankCard==== %@ ",responseObject);
            if ([responseObject[@"code"] intValue] == SUCCESS_CODE) {
                [self addBankButtonSetting];
                
                self.dataArr = @[];
                [self.tabelView reloadData];
                buttonView.hidden = YES;
            }
//            else
//            {
//                MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = responseObject[@"msg"];
//                [hud hide:YES afterDelay:ERROR_DELAY];
//            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

-(void)addBankButtonSetting
{
    UIView *bgView  = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, kScreenWidth, 160)];
    bgView.tag = 134;
    [self.view addSubview:bgView];
    
    UIButton * addBankCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankCardButton.frame = CGRectMake(25, 50, kScreenWidth-44, 45);
    [addBankCardButton setBackgroundImage:[UIImage imageNamed:@"xuxiankuang"] forState:UIControlStateNormal];
    [addBankCardButton setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
    addBankCardButton.showsTouchWhenHighlighted = NO;
    [addBankCardButton setTitle:@"点击添加银行卡" forState:UIControlStateNormal];
    [addBankCardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addBankCardButton addTarget:self action:@selector(addBankCardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBankCardButton];
}

#pragma mark --------PSDbtnClick-------
-(void)buttonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 400: //修改密码
        {
            FindPSDTableVC * findVC = [[FindPSDTableVC alloc]init];
            findVC.number = sender.tag;
            findVC.bankCardID = self.bankID;
            findVC.bankCardNum = self.bankNum;
            UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:findVC];
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        case 401://忘记密码
        {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"ForgetTableVC" bundle:nil];
            ForgetPSWTableVC * forgetVC = [sb instantiateInitialViewController];
            
            UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:forgetVC];
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        case 402://解除
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否解除银行卡绑定" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 300;
            [alert show];
        }
            break;
        default:
            break;
    }
}

- (void)backButtonClick {
    //  [self.navigationController popViewControllerAnimated:YES];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"selectedBtn"];
    [ud synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ------ButtonClick------
-(void)addBankCardButtonClick:(UIButton *)btn
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:1101 forKey:@"selectedBtn"];
    [ud synchronize];
    
    UIView *view = [self.view viewWithTag:134];
    [view removeFromSuperview];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BankCardController" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"cardInfo"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

@end
