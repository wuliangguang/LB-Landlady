//
//  ForgetPasswordViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ZZTimeButton.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "NSUserDefaults+Helper.h"
#import "IphoneNumberHelper.h"
#import "ZZShowMessage.h"
@interface ForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet ZZTimeButton *sendVerifyButton;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

// 发送验证码
- (IBAction)sendVerifyCode:(id)sender {
    [self sendCertifyCode];
}

- (IBAction)submit:(id)sender {
    
   
    [self forgetPasswodNet];
    
}
- (BOOL)verifyInput {
    if (![self.telePhoneTF.text isVAlidPhoneNumber]) {
        [MBProgressHUD showFailToast:s_phone_error inView:self.view completionHandler:nil];
        return NO;
    }
    if ([self.codeTF.text length] <= 0) {
        [MBProgressHUD showFailToast:s_verify_code_error inView:self.view completionHandler:nil];
        return NO;
    }
    if (![self.paswordTF.text isValidPassword]) {
        [MBProgressHUD showFailToast:s_password_error inView:self.view completionHandler:nil];
        return NO;
    }
    if (![self.rePasswordTF.text isEqualToString:self.paswordTF.text]) {
        [MBProgressHUD showFailToast:s_confirm_password_error inView:self.view completionHandler:nil];
        return NO;
    }
    return YES;
}
-(void)forgetPasswodNet
{
    if ([self verifyInput] == NO) {
        return;
    }
    /**
     *   * 	@param	userId		string		电话号码
     * 	@param	password	string	 	密码
     * 	@param	QRCode		string	 	验证码
     * @return  data:{
     * 	code:  true:code=200,false:code!=200
     * 	dataCode: number	返回非错误逻辑性异常code
     * 	resultMsg: string 	返回信息
     * 	totalCount : int	返回总条数
     * 	data:{
     * 	}
     *
     * +(NSString * )forgetPsdForMyInfo;
     */
//    NSDictionary *dict = @{
//                           @"phone" : self.telePhoneTF.text,
//                           @"password" : self.paswordTF.text,
//                           @"QRCode" : self.codeTF.text
//                           };
    NSString *qrcode = self.codeTF.text;
    NSString *password = self.paswordTF.text;
    NSString *mobile = self.telePhoneTF.text;
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSArray *rurur = @[
                       @{@"name":@"password",@"detailStr":password},
                       @{@"name":@"qrcode",@"detailStr":qrcode},
                       @{@"name":@"mobile",@"detailStr":mobile},
    
                       @{@"name":@"source",@"detailStr":source},
                       @{@"name":@"serNum",@"detailStr":serNum},
                       @{@"name":@"reqTime",@"detailStr":reqTime}
                       ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in rurur) {
        SendRequestModel *model = [[SendRequestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    NSString *sign = [SendRequestModel backStrFromeArr:dataArray];
    NSLog(@"----------------sign:%@",sign);
    NSDictionary *parms = @{@"password" : password, @"qrcode" : qrcode,@"mobile":mobile,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign,@"source":source};
    [S_R LB_GetWithURLString:[URLService forgetPsdForMyInfo] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        
        NSLog(@"%@", responseString);
        if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}
// 发送验证码，因接口相同，此处其实可以单独提出去
-(void)sendCertifyCode
{
    [self.sendVerifyButton setEnabled:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getVertifyCode];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:self.telePhoneTF.text  forKey:@"phone"];
        [param setObject:@"2" forKey:@"type"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            [self.sendVerifyButton startBackTime];
            
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}

- (void)initUI {
    self.title = @"忘记密码";
    self.sendVerifyButton.layer.borderColor = LD_COLOR_ONE.CGColor;
    self.sendVerifyButton.layer.borderWidth = 1.0;
    self.sendVerifyButton.backgroundColor = Color(254, 244, 242);
    [self.codeTF setValue:@6 forKey:@"limit"];
    [self.paswordTF setValue:@18 forKey:@"limit"];
    [self.rePasswordTF setValue:@18 forKey:@"limit"];
    [self.telePhoneTF setValue:@11 forKey:@"limit"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
