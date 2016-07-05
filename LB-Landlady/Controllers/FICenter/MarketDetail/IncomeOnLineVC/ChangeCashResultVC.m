//
//  ChangeCashResultVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/28.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "ChangeCashResultVC.h"
#import "CashCardCell.h"
#import "MoneyCell.h"
#import "CardInfoViewController.h"
#import "BindMesModel.h"
#import <UIImageView+WebCache.h>
#import "CashResultDetailViewController.h"
#import "cashVC_almost_money_cell.h"
#import "FindPsdCell.h"
#import "UIViewController+ZZNavigationItem.h"
#import "IncomeDataModel.h"


@interface ChangeCashResultVC () <UITextFieldDelegate>

//@property(nonatomic,strong)UILabel * bankNameLabel;
@property(nonatomic,strong)UILabel * bankAccountLabel;
@property(nonatomic,strong)UITextField * moneyTF;
@property(nonatomic,strong)MBProgressHUD * Mbp;

@property(nonatomic,strong)NSString * cardNumStr;
@property(nonatomic,strong)NSString * password;


@property (nonatomic,strong)NSArray      *bankInfoArray;//数据（已绑定）

@end

@implementation ChangeCashResultVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cardTableView.backgroundColor =[UIColor clearColor];
    self.cardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = Color(235, 235, 235);
    [self initNavigation];
    if (self.incomeType == INCOME_CHANGECASH)
    {
        self.title = @"提现";
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeCashAndEditCard:self.isBind];

    [self bankCardMes];//读取绑定的银行卡信息
    [self getbalance];
}

-(void)initNavigation
{
    [self addStandardBackButtonWithClickSelector:@selector(backButtonClick)];
}

-(void)changeCashAndEditCard:(BOOL)status
{
    if (!status)
    {
        self.cardTableView.hidden = YES;
        self.submitbtn.hidden = YES;
        self.resultLabel.text = @"还没有绑定银行卡，无法提现....";
        self.resultLabel.textColor = [HEXColor getColor:@"#CECECE"];
        self.resultImage.image = [UIImage imageNamed:@"pity"];
    }else
    {
#warning
        self.cardTableView.delegate = self;
        self.cardTableView.dataSource = self;
        self.cardTableView.hidden = NO;
        self.submitbtn.hidden = NO;
        self.resultLabel.hidden = YES;
        self.resultImage.hidden = YES;
        self.bindbtn.hidden = YES ;
    }
}
//cashVC_almost_money_cell
#pragma mark ------------tableViewDatasource --------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            CashCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixian"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CashCardCell" owner:self options:nil] lastObject];
            }
            BindMesModel * model = self.bankInfoArray[indexPath.row];
            [cell.bankImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] ];
            cell.nameLabel.text = model.bankname;
            
            if (model.banknum.length >9) {
                self.cardNumStr = model.banknum;
                NSString *str = [model.banknum substringToIndex:4];
                NSString *str1 = [model.banknum substringFromIndex:model.banknum.length -4];
                cell.accountLabel.text = [NSString stringWithFormat:@"%@ **** **** %@",str,str1];
            }
            return cell;
        }
        case 1:
        {
            MoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"money"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MoneyCell" owner:self options:nil] lastObject];
            }
            return cell;
        }
        default:
        {
            cashVC_almost_money_cell * cell = [tableView dequeueReusableCellWithIdentifier:@"almost_money_cell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"cashVC_almost_money_cell" owner:self options:nil] lastObject];
            }
            cell.amountLab.text = [NSString stringWithFormat:@"%.2f",self.totalMoney];
            return cell;
        }
    }
}

#pragma mark *********************** TableView Delegate ********************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 130 ;
        default:
            return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
        return 0.01;
    return 8 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01 ;
}

#pragma mark --------alertViewDelegate -------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.view endEditing:YES];
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            if (_password.length !=6 ) {
                _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _Mbp.mode = MBProgressHUDModeText;
                _Mbp.labelText = @"请输入六位数提现密码";
                [_Mbp hide:YES afterDelay:ERROR_DELAY];
            }else
            {
                [self cashRequest:_password];
            }
            
        }
    }
    
}

#pragma mark --------btnClick -------
- (IBAction)submitBtnClick:(id)sender
{
    [self.view endEditing:YES];
    self.bankAccountLabel = (UILabel *)[self.view viewWithTag:1991];
    self.moneyTF = (UITextField *)[self.view viewWithTag:1992];
    
    //有银行卡~提交提现请求
    NSString * moneyStr = [self.moneyTF.text removeWhiteSpacesFromString];
    
    NSString * mes = nil;
    if (self.moneyTF.text.length>2) {
        NSString * ONE = [self.moneyTF.text substringWithRange:NSMakeRange(0, 1)];
        NSString * TWO = [self.moneyTF.text substringWithRange:NSMakeRange(1, 1)];
        if ([ONE isEqualToString:@"0"]&&![TWO isEqualToString:@"."]) {
            mes = @"请输入正确金额";
        }
    }
    
    
    if (moneyStr.length == 0 )
    {
        mes = @"请输入提现金额";
    }
    else if ([moneyStr floatValue]<=0)
    {
        mes = @"请输入正确的金额";
    }else if ([moneyStr floatValue] > self.totalMoney)
    {
        mes = @"余额不足";
    }else if ([moneyStr rangeOfString:@"."].location != NSNotFound)
    {
        if ([[moneyStr componentsSeparatedByString:@"."]lastObject].length > 2) {
            // FMLog(@"%d",[[moneyStr componentsSeparatedByString:@"."]lastObject].length);
            mes = @"最多可输入小数点后两位";
        }else if ([[moneyStr componentsSeparatedByString:@"."]lastObject].length ==0){
             mes = @"请输入正确的金额";
        }
        
    }
//    else if ([[moneyStr componentsSeparatedByString:@"."]lastObject].length ==0)
//    {
//        mes = @"请输入正确的金额";
//    }
    if (mes == nil)
        
    {
        mes = @"请输入提现密码";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        FindPsdCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FindPsdCell" owner:self options:nil] lastObject];
        cell.frame = CGRectMake(10, 30, kScreenWidth-50, (kScreenWidth-50)*128/407.0+20);
        cell.backgroundColor = [UIColor clearColor];
        cell.tilteLab.text = @"请输入提现密码";
        [alert setValue:cell forKey:@"accessoryView"];
        
        alert.tag = 1000;
        
        cell.psd = ^(NSString * password){
            self.password = password;
        };
        [alert show];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:mes message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

- (IBAction)bindBtnClick:(id)sender
{
    //去绑定银行卡
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"BankCardController" bundle:nil];
    CardInfoViewController * InfoVC = [storyBoard instantiateViewControllerWithIdentifier:@"cardInfo"];
    [self.navigationController pushViewController:InfoVC animated:YES];
}
-(void)backButtonClick{
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"selectedBtn"];
    [ud synchronize];
    [self.navigationController popViewControllerAnimated:YES];}

#pragma mark ------NetRequest-------

-(void)bankCardMes
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getBankListUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [S_R LB_PostWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                //                FMLog(@"responseObject===%@",responseObject);
                _bankInfoArray = [BindMesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"bankList"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.cardTableView reloadData];
                });
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
-(void)cashRequest:(NSString *)psd
{
    //@param	userid		string		用户ID
    //*	@param	banknum		string		银行卡号
    //*	@param	payPwd		string		支付密码
    //*	@param	amount		string		金额

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService withdrawUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [params setObject:self.cardNumStr forKey:@"banknum"];
        [params setObject:psd forKey:@"payPwd"];
        [params setObject:self.moneyTF.text forKey:@"amount"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                //                FMLog(@"responseObject===%@",responseObject);
                _bankInfoArray = [BindMesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"bankList"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    CashResultDetailViewController *cashResult = [[CashResultDetailViewController alloc]init];
                    [self.navigationController pushViewController:cashResult animated:YES];
                });
            }else{
                MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = responseObject[@"msg"];
                [hud hide:YES afterDelay:ERROR_DELAY];
            }
            
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
-(void)getbalance
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getBalanceUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
            if (commonModel.code == SUCCESS_CODE) {
                IncomeDataModel *income = commonModel.data;
                self.totalMoney = [income.count floatValue]/100;
            }else
            {
                self.totalMoney = 0;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cardTableView reloadData];
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

@end
