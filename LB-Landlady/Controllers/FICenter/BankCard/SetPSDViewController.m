//
//  SetPSDViewController.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/27.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "SetPSDViewController.h"
#import "PSDCell.h"
#import "BindResultViewController.h"
#import "UIViewController+ZZNavigationItem.h"

@interface SetPSDViewController ()
@property(nonatomic,strong)UITextField * psdTF ;
@property(nonatomic,strong)UITextField * sureTF ;
@property(nonatomic,strong)MBProgressHUD * MBP;


@end

@implementation SetPSDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self initNavigation];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = Color(237, 237, 237);
    self.title = @"提现密码设置";
}

-(void)initNavigation{
    [self addStandardBackButtonWithClickSelector:@selector(backButtonClick)];
}

- (void)backButtonClick {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"selectedBtn"];
    [ud synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    // [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark --------btnClick-----
- (IBAction)sureButtonClick:(id)sender
{
    [self.view endEditing:YES];
    self.psdTF = (UITextField *)[self.view viewWithTag:2015];
    self.sureTF = (UITextField *)[self.view viewWithTag:2016];
    NSString * mes = nil ;
    if ([self.psdTF.text isBlank])
    {
        mes = @"请输入提现密码";
    }else if ([self.sureTF.text isBlank])
    {
        mes = @"请输入确认密码";
    }else if (self.psdTF.text.length != 6&&self.sureTF.text.length != 6)
    {
        mes = @"请设置六位数提现密码" ;
    }else if (![self.psdTF.text isEqualToString:self.sureTF.text])
    {
        mes = @"两次输入的密码不一致";
    }else {
        NSArray *arr = @[@"000000",@"111111",@"222222",@"333333",@"444444",@"555555",@"666666",@"777777",@"888888",@"999999",@"012345",@"123456",@"234567",@"345678",@"456789",@"543210",@"654321",@"765432",@"876543",@"987654"];
        for (NSString *str in arr)
        {
            if ([str isEqualToString:self.psdTF.text])
            {
                mes = @"输入密码过于简单";
            }
        }
        
    
    
    }
    if (mes) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:mes delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alert show];
    }else
    {
        [self bindBankCard];//密码设置成功，添加提现密码
    }
    
}

#pragma mark ------------netRequest --------------

-(void)bindBankCard
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService addBankUrl];
        UITextField * psdTF = (UITextField *)[self.view viewWithTag:2015];
        [self.pare setObject:psdTF.text forKey:@"paypwd"];
        [S_R LB_GetWithURLString:urlStr WithParams:self.pare WithSuccess:^(id responseObject, id responseString) {
            
            FMLog(@"setPSD ===%@",responseObject);
            NSNumber * status = nil;
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                status = [NSNumber numberWithInt:0];
            }else
            {
                status = [NSNumber numberWithInt:100];
            }
//            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                [self performSegueWithIdentifier:@"result" sender:status];
//            }
        } failure:^(NSError *error) {

        } WithController:self];
    });
}


-(void)goBack
{
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"dismiss");
    }];
}
    

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"result"])
    {
        BindResultViewController *bindVC = [segue destinationViewController];
        bindVC.resultType = sender;
    }
}
#pragma mark ------------tableView dataSource ----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSDCell * cell = (PSDCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.editTextField becomeFirstResponder];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [[NSArray alloc]initWithObjects:@"提现密码",@"确认密码", nil];
    PSDCell * cell = [tableView dequeueReusableCellWithIdentifier:@"psd"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PSDCell" owner:self options:nil] lastObject];
    }
    cell.nameLabel.text = array[indexPath.row];
    cell.editTextField.tag = 2015 + indexPath.row ;
    [cell.editTextField setValue:@6 forKey:@"limit"];
    cell.editTextField.delegate = self;
    return cell ;
}
#pragma mark -----textFieldDelegate ----

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.psdTF)
    {

        [self.psdTF resignFirstResponder];
        [self.sureTF becomeFirstResponder];
    }
    else if (textField == self.sureTF)
    {
        [self.sureTF resignFirstResponder];
      
    }


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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
