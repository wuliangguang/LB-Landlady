//
//  MarketDetailMainViewController.m
//  MeZoneB_Bate
//
//  Created by d2space on 15/9/21.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "MarketDetailMainViewController.h"
#import "MD_Main_HeaderView.h"
#import "IncomeOnlineViewController.h"

#import "ChangeCashResultVC.h"
#import "FetchDetailViewController.h"
#import "BankViewController.h"
#import "AddCardViewController.h"
#import "PayTableVC.h"
#import "IncomeDataModel.h"
#import "NSString+Formatter.h"
#import "BussinessAmountCell.h"
#import "AmountSituationCell.h"
@interface MarketDetailMainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray            *btnTitles;
@property(nonatomic,strong)NSString * summary;
@property (nonatomic, assign) NSInteger           selectedBtn;//记录选择的btn
//@property (nonatomic,assign)float totalMoney;
@property (nonatomic,strong)MBProgressHUD * Mbp;
@property(nonatomic,strong)NSNumber * isBind;
@end

@implementation MarketDetailMainViewController

#pragma mark *********************** ViewController Life Cycle ********************
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"selectedBtn"] == 1100)
    {
        [self pushToChangeCash];
    }
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"selectedBtn"] == 1101)
    {
        [self pushToBankCard];
    }
    [self isBindCard];//判断是否添加过银行卡
    [self getbalance];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"财务管理";
    self.btnTitles = @[@"pay",@"cash",@"card",@"detailsale"];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BussinessAmountCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BussinessAmountCell class])];//AmountSituationCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AmountSituationCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AmountSituationCell class])];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"selectedBtn"];
    [ud synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark *********************** Btn Method ********************
- (void)incomeBtnType:(UIButton *)btn {
    if (btn.tag==1099)//充值
    {
        _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _Mbp.mode = MBProgressHUDModeText;
        _Mbp.labelText = @"正在建设中...";
        [_Mbp hide:YES afterDelay:1];
    }else
    {
        if ([_isBind  isEqual: @0])
        {
            self.selectedBtn = btn.tag;
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setInteger:btn.tag forKey:@"selectedBtn"];
            [ud synchronize];
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"BankCardController" bundle:nil];
            AddCardViewController * addVC = [storyBoard instantiateViewControllerWithIdentifier:@"addBankCard"];
            switch (btn.tag) {
                case 1099:
                    addVC.name = @"充值";
                    break;
                case 1100:
                    addVC.name = @"提现";
                    break;
                case 1101:
                    addVC.name = @"银行卡";
                    break;
                case 1102:
                    addVC.name = @"交易明细";
                    break;
            }
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:addVC];
            [self presentViewController:navc animated:NO completion:nil];
        }else
        {
            //提现
            if (btn.tag == 1100)
            {
                [self pushToChangeCash];
            }
            //银行卡
            else if (btn.tag == 1101)
            {
                [self pushToBankCard];
            }
            
            else//交易明细
            {
                FetchDetailViewController *fetchDetailView = [[FetchDetailViewController alloc]init];
                fetchDetailView.totalCount = [NSString stringWithFormat:@"%.2f",[self.summary floatValue]];
                [self.navigationController pushViewController:fetchDetailView animated:YES];
            }
        }
    }
}

#pragma mark *********************** Private Method ********************
- (void)pushToBankCard
{
    self.selectedBtn = 0;
    BankViewController *bankView = [[BankViewController alloc]init];
    bankView.isBind = (BOOL)_isBind;
    [self.navigationController pushViewController:bankView animated:NO];
}
- (void)pushToChangeCash
{
    self.selectedBtn = 0;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ChangeCashResultVC" bundle:nil];
    ChangeCashResultVC *ioc = [storyBoard instantiateViewControllerWithIdentifier:@"cashresult"];
//    NSLog(@"------------self.summary:%@",self.summary);
    ioc.totalMoney = [self.summary floatValue]/100;
    ioc.incomeType = INCOME_CHANGECASH;
    ioc.isBind = (BOOL)_isBind;
    [self.navigationController pushViewController:ioc animated:NO];
}
#pragma mark *********************** TableView DataSource ********************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
            case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            BussinessAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BussinessAmountCell class])];
            cell.selectionStyle = UITableViewScrollPositionNone;
            return cell;
        }
            break;
        case 1:
        {
            AmountSituationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AmountSituationCell class])];
            cell.selectionStyle = UITableViewScrollPositionNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *identify = @"identify";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            }
            for (int i = 0; i < 4; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake((kScreenWidth/4)*i, 0, kScreenWidth/4, kScreenWidth/4);
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = 1099+i;
                [btn setImage:[UIImage imageNamed:self.btnTitles[i]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(incomeBtnType:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
                
                if (i > 0  && i <4)
                {
                    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/4)*i, 10, 1, (kScreenWidth/4)-20)];
                    lineLabel.backgroundColor = Color(240, 240, 240);
                    [cell.contentView addSubview:lineLabel];
                }
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark *********************** TableView Delegate ********************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 146;
    }else if (indexPath.section == 1){
        return 100;
    }
    return kScreenWidth/4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return (kScreenWidth/5)*2;
    }else{
        return 0.01;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"MarketDetailMainHeader" owner:self options:nil];
        
        MD_Main_HeaderView *headerView = nil;
        
        if (views.count > 0)
        {
            headerView = views[0];
            headerView.titleLabel.text = @"账户余额 (元)";
            headerView.frame = CGRectMake(0, 0,kScreenWidth , (kScreenWidth/5)*2);
            UIImageView *textLeftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 13, 13)];
            textLeftView.image = [UIImage imageNamed:@"Safe_Account_Icon"];
            headerView.noticeLabel.leftView = textLeftView;
            headerView.noticeLabel.leftViewMode = UITextFieldViewModeAlways;
            headerView.priceLabel.text = self.summary.formatPriceTwo;
        }
        return headerView;
    }
    return nil;
}
#pragma mark ------NetRequest-------
-(void)isBindCard
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getIsTrueUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        if (App_User_Info.myInfo.userModel.userId == nil) {
            return ;
        }
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [S_R LB_PostWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                FMLog(@"responseObject===%@",responseObject);
                
                //1绑定 0 没绑定
                _isBind = responseObject[@"data"][@"isTrue"];
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
            NSLog(@"-----------z账户余额%@",responseObject);
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
            if (commonModel.code == SUCCESS_CODE) {
                IncomeDataModel *income = commonModel.data;
                self.summary =[NSString stringWithFormat:@"%.2f",[income.count floatValue]/100];
                if([self.summary isEqualToString:@"0.00"]){
                    self.summary = @"0";
                }
            }else
            {
                self.summary = @"0";
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}


@end
