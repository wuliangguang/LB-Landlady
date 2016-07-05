//
//  CardInfoViewController.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/27.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "CardInfoViewController.h"
#import "CardInfoCell.h"
#import "BankNameCell.h"
#import "BankListVC.h"
//#import "BankNameModel.h"
//#import "BottomCell.h"
#import "UIViewController+ZZNavigationItem.h"
#import "SetPSDViewController.h"

@interface CardInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,strong)NSMutableArray * bankArray;
//@property(nonatomic,strong)UITableView * bankTableView;
//@property(nonatomic,strong)UIView * backView;
//@property(nonatomic,strong)NSArray * bankNameArr;
@property(nonatomic,strong)UITableView * InfoTableView;
@property(nonatomic,strong)NSString * name ;//银行名字
@property(nonatomic,strong)NSNumber * bankId ;//银行id
@property(nonatomic,strong)UITextField *nameTf;//持卡人姓名
@property(nonatomic,strong)UITextField *numTf;//银行卡账号
@property(nonatomic,strong)UITextField *phoneTf;//手机号
@property(nonatomic,strong)UILabel *BankNameLabel;//银行名称
@end

@implementation CardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"添加银行卡";
    self.view.backgroundColor = Color(237, 237, 237);
    [self initTableView];
    [self initNavigation];
}

-(void)initNavigation{
    [self addStandardBackButtonWithClickSelector:@selector(backButtonClick)];
}

- (void)backButtonClick {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"selectedBtn"];
    [ud synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----------init------
-(void)initTableView{
    self.InfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20) style:UITableViewStyleGrouped];
    self.InfoTableView.delegate = self;
    self.InfoTableView.dataSource = self;
    self.InfoTableView.tag = 10001;
    [self.view addSubview:self.InfoTableView];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(22, 58*4+8, kScreenWidth-44, 45);
    [button setBackgroundImage:[UIImage imageNamed:@"blueButton"] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.InfoTableView addSubview:button];
}

#pragma mark ------------tableView dataSource ----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (indexPath.section != 1) {
            CardInfoCell * cell = (CardInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell.editTextField becomeFirstResponder];
        }else{
            [self.view endEditing:YES];
            //弹出开户行界面
            [self performSegueWithIdentifier:@"banklist" sender:nil];
            

        }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSArray * array = [[NSArray alloc]initWithObjects:@"持卡人",@"开户行",@"卡号",@"手机号", nil];
        
        if (indexPath.section != 1) {
            CardInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cardInfoCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CardInfoCell" owner:self options:nil] lastObject];
            }
            if (indexPath.section ==2||indexPath.section ==3) {
                cell.editTextField.keyboardType = UIKeyboardTypeNumberPad;
                if (indexPath.section == 3) {
                    [cell.editTextField setValue:@11 forKey:@"limit"];
                }else
                {
                    [cell.editTextField setValue:@19 forKey:@"limit"];
                }
            }
            cell.tipLabel.text = array[indexPath.section];
            cell.editTextField.tag = 600 +indexPath.section;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startTextFieldEdit:) name:UITextFieldTextDidChangeNotification object:cell.editTextField];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            BankNameCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bankName"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BankNameCell" owner:self options:nil] lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tipLabel.text = array[indexPath.section];
            return cell ;
        }
}

#pragma mark ----------btnClick ------
-(void)nextButtonClick
{
    [self.view endEditing:YES];
    self.nameTf = (UITextField *)[self.view viewWithTag:600];
    self.numTf = (UITextField *)[self.view viewWithTag:602];
    self.phoneTf = (UITextField *)[self.view viewWithTag:603];
    self.BankNameLabel = (UILabel *)[self.view viewWithTag:505];
    NSString * mes = nil ;
    if (self.nameTf.text.length == 0 )
    {
        mes =@"请输入持卡人姓名";
    }else if (self.BankNameLabel.text.length == 0 )
    {
        mes = @"请选择开户行";
    }else if (self.numTf.text.length < 16)
    {
        mes = @"请输入正确的卡号";
    }else if (![self.phoneTf.text isVAlidPhoneNumber])
    {
        mes = @"请输入正确的手机号";
    }
    if (mes) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:mes delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
    } else {
        // SetPSDViewController
        [self performSegueWithIdentifier:@"psd" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"psd"]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];//
        [params setObject:self.nameTf.text forKey:@"contactName"];//
        [params setObject:self.numTf.text forKey:@"bankNum"];
        [params setObject:self.phoneTf.text forKey:@"phone"];//
        [params setObject:self.bankId forKey:@"bankId"];//
        
        [params setObject:[self.BankNameLabel.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"bankName"];//
        
        SetPSDViewController *pwd = [segue destinationViewController];
        pwd.pare = params;
    }else if ([segue.identifier isEqualToString:@"banklist"])
    {
        BankListVC * bankVC = [segue destinationViewController];
        bankVC.strBlock = ^(BankNameModel * bankModel){
            UILabel *nameLabel = (UILabel *)[self.view viewWithTag:505];
            nameLabel.text = bankModel.name;
            self.bankId = bankModel.ID;
        };
        bankVC.infoVC = self;
    }

}

-(void)startTextFieldEdit:(NSNotification *)obj
{
    UITextField *tx = (UITextField *)obj.object;
    NSString *string = tx.text;

    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        if (substring.length == 2)
        {
            tx.text = [tx.text stringByReplacingOccurrencesOfString:substring withString:@""];
        }

    }];
}
//#pragma mark ---------netRequest -----
//-(void)addBankCard
//{
//    /**
//     *  绑定银行卡
//     *
//     *	@param  	bankNum			string		卡号ID
//     * 	@param		bankName		string		卡名称
//     * 	@param		contactName		string 		联系人
//     * 	@param		paypwd			string		支付密码
//     * 	@param		phone			string		电话号码
//     * 	@param		userId		string		用户ID
//     * 	@param		 bankId			string		银行卡类型
//     */
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSString * urlStr = [URLService addBankUrl];
//        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
//        if (App_User_Info.haveLogIn == NO) {
//            return ;
//        }
//        
//        [params setObject:App_User_Info.myInfo.user.user_id forKey:@"userId"];
//        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
//            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
//                FMLog(@"responseObject===%@",responseObject);
//                //                dispatch_async(dispatch_get_main_queue(), ^{
//                //                    [self.tableview reloadData];
//                //                });
//            }
//        } failure:^(NSError *error) {
//            
//        } WithController:self];
//    });
//}
//
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
