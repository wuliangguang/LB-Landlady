//
//  MyBasicChangePasswordViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyBasicChangePasswordViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "ZZCommonLimit.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "ZZShowMessage.h"
#import "NSUserDefaults+Helper.h"

@interface MyBasicChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *originPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;

@end

@implementation MyBasicChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initUI];
}

- (void)initUI {
    self.title = @"修改登录密码";
    UIButton *button = [self addStandardRightButtonWithTitle:@"保存" selector:@selector(save)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [ZZCommonLimit passwordLimit:self.originPasswordField];
    [ZZCommonLimit passwordLimit:self.rePasswordField];
    [ZZCommonLimit passwordLimit:self.confirmPasswordField];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (void)save {
    /**
     * @see 修改密码
     * @author kai.li
     * 	@param	userId		string		用户ID
     * 	@param	password	string	 	新密码
     * 	@param	repassword	string	 	重复密码
     * @return  data:{
     * 	code:  true:code=200,false:code!=200
     * 	dataCode: number	返回非错误逻辑性异常code
     * 	resultMsg: string 	返回信息
     * 	totalCount : int	返回总条数
     * 	data:{1860130
     * 	}
     */
    NSDictionary *dict = [self verifyInputData];
    if (!dict) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [S_R LB_PostWithURLString:[URLService rePasswordUrl] WithParams:dict WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"------------修改密码:%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            [MBProgressHUD showSuccessToast:s_modify_password_success inView:self.view completionHandler:nil];
            [NSUserDefaults standardUserDefaults].password = self.rePasswordField.text;
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            //[MBProgressHUD showFailToast:commonModel.msg inView:self.view completionHandler:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showFailToast:s_modify_password_fail inView:self.view completionHandler:nil];
    } WithController:self];
}

- (NSDictionary *)verifyInputData {
    if ([self.originPasswordField.text isValidPassword] == NO || [self.originPasswordField.text isEqualToString:[NSUserDefaults standardUserDefaults].password] == NO) {
        [MBProgressHUD showFailToast:s_password_error inView:self.view completionHandler:nil];
        return nil;
    }
    if ([self.rePasswordField.text isValidPassword] == NO) {
        [MBProgressHUD showFailToast:s_password_error inView:self.view completionHandler:nil];
        return nil;
    }
    if ([self.confirmPasswordField.text isEqualToString:self.rePasswordField.text] == NO) {
        [MBProgressHUD showFailToast:s_confirm_password_error inView:self.view completionHandler:nil];
        return nil;
    }

    NSString *userId =App_User_Info.myInfo.userModel.userId;
    NSString *password = self.rePasswordField.text;
    NSString *newPassword = self.rePasswordField.text;
    NSDate *date = [[NSDate alloc]init];
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",newPassword,password,reqTime,serNum,source,userId,s_key];
    sign = [sign mdd5];
    NSDictionary *info = @{@"userId" : userId, @"newPassword":newPassword, @"password" : password,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    return info;
}

@end
