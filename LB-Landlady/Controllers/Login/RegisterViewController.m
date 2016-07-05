//
//  RegisterViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZZTimeButton.h"
#import "InfoWebViewController.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "ZZShowMessage.h"
#import "NSUserDefaults+Helper.h"
#import "IphoneNumberHelper.h"

@interface RegistData : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *code;
@end

@implementation RegistData

@end

@interface RegistModel : NSObject

@property (nonatomic, copy) NSString *phone;       // 手机号
@property (nonatomic, copy) NSString *password;    // 密码
@property (nonatomic, copy) NSString *repassword;  // 重新输入的密码
@property (nonatomic, copy) NSString *QRCode;      // 验证码
@end

@implementation RegistModel
@end

@interface RegisterViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ZZTimeButton *sendVerifyCodeButton; // button: 发送验证码
@property (weak, nonatomic) IBOutlet UITextField *phoneField;            // 手机号
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;       // 验证码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;         // 密码
@property (weak, nonatomic) IBOutlet UIButton *agressButton;
- (IBAction)agressButtonClock:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;  // 确认密码
- (IBAction)businessMakeButtonClock:(id)sender;
//商户服务协议
@property (nonatomic) RegistModel *registModel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.sendVerifyCodeButton.layer.borderColor = LD_COLOR_ONE.CGColor;
    self.sendVerifyCodeButton.layer.borderWidth = 1.0;
    self.sendVerifyCodeButton.backgroundColor = Color(254, 244, 242);
    [self.passwordField setValue:@18 forKey:@"limit"];
    [self.confirmPasswordField setValue:@18 forKey:@"limit"];
    [self.verifyCodeField setValue:@6 forKey:@"limit"];
    self.phoneField.delegate = self;
    self.title = @"注册";
    [self.agressButton setBackgroundImage:[UIImage imageNamed:@"my_merchant_not_check"] forState:UIControlStateNormal];
    [self.agressButton setBackgroundImage:[UIImage imageNamed:@"my_merchant_check"] forState:UIControlStateSelected];
}

#pragma mark - <UITextFieldDelegate>
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.phoneField)
    {
        if ([aString length] > 11)
        {
            textField.text = [aString substringToIndex:11];
            return NO;
        }
        BOOL isIphoneNumber = [IphoneNumberHelper iphoneNumberInputRule:aString InputString:string];
        return isIphoneNumber;
    }
    if (textField == self.passwordField)
    {
        if ([aString length] > 16)
        {
            textField.text = [aString substringToIndex:16];
            return NO;
        }
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

// 发送验证码
- (IBAction)sendVerifyCode:(ZZTimeButton *)timeButton {
    if (![self.phoneField.text isVAlidPhoneNumber]) {
        [MBProgressHUD showFailToast:s_phone_error inView:self.view completionHandler:nil];
        return;
    }
    
    [timeButton setEnabled:NO];
    
    [self.view endEditing:YES];
  
    // 验证码应该发到用户手机上，此处服务器暂时只是返回
    NSString * urlStr = [URLService getVertifyCode];
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *mobile = self.registModel.phone;
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",mobile,reqTime,serNum,source,s_key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"mobile" : mobile,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [S_R LB_GetWithURLString:urlStr WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"----------验证码:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            [self.sendVerifyCodeButton startBackTime];
        } else {
            [timeButton setEnabled:YES];
        }
    } failure:^(NSError *error) {
        FMLog(@"error = %@",error.userInfo);
        [timeButton setEnabled:YES];
    } WithController:self];
}

// 软件使用协议
- (IBAction)useAgreement:(id)sender {
    // TODO:
    NSLog(@"软件使用协议");
    
    InfoWebViewController *controller = [[InfoWebViewController alloc] init];
    controller.title = @"老板娘电子平台合作协议";
    controller.urlStr = [URLService getSystemProtocolUrl];
    controller.showOnly = YES;
    UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nivController animated:YES completion:nil];
}

- (IBAction)regist:(id)sender {
    [self.view endEditing:YES];
    [self requestRegister];
}
//businessMakeButtonClock
- (IBAction)businessMakeButtonClock:(id)sender {
    InfoWebViewController *controller = [[InfoWebViewController alloc] init];
    controller.title = @"商户使用服务协议";
    controller.urlStr = [URLService getSystemMakeUrl];
    controller.showOnly = YES;
    UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nivController animated:YES completion:nil];
}

- (RegistModel *)registModel {
    if (_registModel == nil) {
        _registModel = [[RegistModel alloc] init];
    }
    return _registModel;
}

- (void)requestRegister {
    if ([self verifyInput] == NO) {
        return ;
    }
    
    /**
     * 	@param	phone		string		电话号码
     * 	@param	password	string	 	密码
     * 	@param	repassword	string	 	重复密码
     * 	@param	QRCode		string	 	验证码
     */
    NSString *urlStr = [URLService regist];
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    
    NSString *mobile = self.phoneField.text;
    NSString *password = self.passwordField.text;
    NSString *qrcode = self.verifyCodeField.text;
    NSArray *rurur = @[
                       @{@"name":@"mobile",@"detailStr":mobile},
                       @{@"name":@"source",@"detailStr":source},
                       @{@"name":@"serNum",@"detailStr":serNum},
                       @{@"name":@"reqTime",@"detailStr":reqTime},
                       @{@"name":@"qrcode",@"detailStr":qrcode},
                       @{@"name":@"password",@"detailStr":password}
                       ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in rurur) {
        SendRequestModel *model = [[SendRequestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    NSString *sign = [SendRequestModel backStrFromeArr:dataArray];

    NSDictionary *parms = @{@"mobile" : mobile, @"password" : password,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign,@"qrcode":qrcode};
    
    [S_R LB_PostWithURLString:urlStr WithParams:parms WithSuccess:^(id responseObject, id responseString) {
          NSLog(@"----------注册:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[RegistData class]];
        if (commonModel.code == SUCCESS_CODE) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        //[MBProgressHUD showFailToast:@"注册失败" inView:self.view completionHandler:nil];
    } WithController:self];
}

/**
 *  验证用户输入
 *
 *  @return 输入合法返回YES, 否则返回NO
 */
- (BOOL)verifyInput {
    if (![self.phoneField.text isVAlidPhoneNumber]) {
        NSLog(@"%@", self.phoneField.text);
        [MBProgressHUD showFailToast:s_phone_error inView:self.view completionHandler:nil];
        return NO;
    }
    if ([self.verifyCodeField.text length] <= 0) {
        [MBProgressHUD showFailToast:s_verify_code_error inView:self.view completionHandler:nil];
        return NO;
    }
    if (![self.passwordField.text isValidPassword] && [self checkPassword:self.passwordField.text]) {
        [MBProgressHUD showFailToast:s_password_error inView:self.view completionHandler:nil];
        return NO;
    }
    if (![self.passwordField.text isEqualToString:self.confirmPasswordField.text]) {
        [MBProgressHUD showFailToast:s_confirm_password_error inView:self.view completionHandler:nil];
        return NO;
    }
    if (!self.agressButton.selected) {
        [MBProgressHUD showFailToast:@"请认真阅读协议,并点击同意" inView:self.view completionHandler:nil];
        return NO;
    }
    self.registModel.phone      = self.phoneField.text;
    self.registModel.password   = self.passwordField.text;
    self.registModel.repassword = self.confirmPasswordField.text;
    self.registModel.QRCode     = self.verifyCodeField.text;
    
    return YES;
}
- (BOOL)checkPassword:(NSString*) password

{
    
    NSString*pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"%@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [self.sendVerifyCodeButton invalidTimer];
}

- (IBAction)agressButtonClock:(id)sender {
    self.agressButton.selected = !self.agressButton.selected;
}
@end
