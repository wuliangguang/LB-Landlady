//
//  FeedBackViewController.m
//  LB-Landlady
//
//  Created by d2space on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "FeedBackViewController.h"
#import "SZTextView.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (nonatomic, strong) SZTextView *textView;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    [self initTitleText];
    [self initContentTextView];
    [self initCommitBtn];
}
- (void)initTitleText
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    self.titleText.leftView = leftView;
    self.titleText.leftViewMode = UITextFieldViewModeAlways;
    [self.titleText setValue:@20 forKey:@"limit"];
}
- (void)initContentTextView
{
    _textView = [[SZTextView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, 250)];
    _textView.placeholder = @"请输入产品意见，我们将不断优化体验";
    [_textView setValue:@200 forKey:@"limit"];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textView];
}
- (void)initCommitBtn
{
    UIButton *btn           = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame               = CGRectMake(20, 340, (kScreenWidth - 40), 44);
    btn.layer.cornerRadius  = 2;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor     = LD_COLOR_ONE;
    [self.view addSubview:btn];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commitFeedBack:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commitFeedBack:(UIButton *)btn {
    if ([self authCommitContent])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSString * urlStr = [URLService getFeedBackUrl];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:self.titleText.text forKey:@"title"];
            [param setObject:self.textView.text  forKey:@"contant"];
            [param setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
            [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
                if ([[responseObject objectForKey:@"code"] integerValue] == SUCCESS_CODE) { // 提交成功
                    [MBProgressHUD showSuccessToast:@"提交成功" inView:self.view completionHandler:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [MBProgressHUD showFailToast:@"提交失败" inView:self.view completionHandler:nil];
                }
            } failure:^(NSError *error) {
                 NSLog(@"error = %@",error.userInfo);
                [MBProgressHUD showFailToast:@"提交失败" inView:self.view completionHandler:nil];
            } WithController:self];
        });
    }
}

- (BOOL)authCommitContent
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    if (self.titleText.text.length == 0)
    {
        hud.labelText = @"请输入标题";
        [hud hide:YES afterDelay:ERROR_DELAY];
        return NO;
    }
    
    if (self.textView.text.length == 0)
    {
        hud.labelText = @"请输入内容";
        [hud hide:YES afterDelay:ERROR_DELAY];
        return NO;
    }
    [hud hide:YES];
    return YES;
}

@end
