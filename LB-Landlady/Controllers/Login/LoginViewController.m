//
//  LoginViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "ZZShowMessage.h"
#import "NSUserDefaults+Helper.h"
#import "IphoneNumberHelper.h"
#import "CommonModel.h"
#import "MyInfoDataModel.h"
#import "MyMessageManager.h"
#import "LoginManager.h"

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    ADD_STANDARD_BACK_NAV_BUTTON;
    self.title = @"登录";
    UIButton *button = [self addStandardRightButtonWithTitle:@"注册" selector:@selector(regist)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.phoneField.delegate = self;
    
    // 密码不超过18位，最小6位
    [self.passwordField setValue:@18 forKey:@"limit"];
    [self addStandardBackButtonWithClickSelector:@selector(back)];
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

#pragma mark -

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)regist {
    RegisterViewController *controller = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([RegisterViewController class])];
    [self.navigationController pushViewController:controller animated:YES];
}

// 忘记密码
- (IBAction)forgetPassword:(id)sender {
    // TODO:
    NSLog(@"忘记密码");
}

// 登录
- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    [self requestLogIn];
}

- (void)requestLogIn {
    NSDictionary *dict = [self verifyInputData];
    if (dict) {
        [LoginManager loginWithInfo:dict controller:self completionHandler:^(LoginStatus status) {
            switch (status) {
                case LoginStatusSuccess: {
                    [NSUserDefaults standardUserDefaults].username = self.phoneField.text;
                    [NSUserDefaults standardUserDefaults].password = self.passwordField.text;
                    if (self.callbackHandler) {
                        self.callbackHandler(App_User_Info.myInfo);
                    }
                    [self back];
                    break;
                }
//                case LoginStatusFail: {
//                    [MBProgressHUD showFailToast:@"账号或密码错误!" inView:self.view completionHandler:nil];
//                    break;
//                }
                default:
                    break;
            }
        }];
    }
}

// 验证输入是否合法
- (NSDictionary *)verifyInputData {
    NSString *mobile    = self.phoneField.text;
    NSString *password = self.passwordField.text;
    if ([mobile isVAlidPhoneNumber] == NO) {
        [MBProgressHUD showFailToast:s_phone_error inView:self.view completionHandler:nil];
        return nil;
    }
    if ([password isValidPassword] == NO) {
        [MBProgressHUD showFailToast:s_password_error inView:self.view completionHandler:nil];
        return nil;
    }
    NSDate *date = [[NSDate alloc]init];
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@",mobile,password,reqTime,serNum,source,s_key];
    sign = [sign mdd5];
    NSDictionary *info = @{@"mobile" : mobile, @"password" : password,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    //NSLog(@"-------------------info:%@",info);
    return info;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [self.tableView deselectRowAtIndexPath:(nonnull NSIndexPath *) animated:(BOOL)]
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:YES];
}

@end
