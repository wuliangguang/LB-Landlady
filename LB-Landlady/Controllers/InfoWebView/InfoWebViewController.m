//
//  InfoWebViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//
#import "InfoWebViewController.h"

#import "UIViewController+ZZNavigationItem.h"
#import "LoginViewController.h"

@interface InfoWebViewController () <UIWebViewDelegate>

@property (nonatomic) UIWebView *webView;
@end

@implementation InfoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)initUI {
    [self addStandardBackButtonWithClickSelector:@selector(back)];
    
    if (App_User_Info.haveLogIn == NO && self.showOnly == NO) { // 如果没有登录，并且showOnly属性为NO，显示登录按钮
        UIButton *button = [self addStandardRightButtonWithTitle:@"登录" selector:@selector(login)];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 40)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)login {
    LoginViewController *loginController = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    if (self.callbackHandler) {
        loginController.callbackHandler = self.callbackHandler;
    }
    [self.navigationController pushViewController:loginController animated:YES];
}

#pragma mark - <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.showOnly == NO) {
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    /**
    __weak typeof(self) safeSelf = self;
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"liuweizhen"] =
    ^(NSString *title ,NSString *content ,NSString *url,NSString *image,NSString *mobileNumber)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            // NSLog(@"%d", [NSThread isMainThread]); // 0
            LoginViewController *controller = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
            [safeSelf.navigationController pushViewController:controller animated:YES];
        });
    };
     */
}

- (void)back {
     if (self.webView.canGoBack) {
         [self.webView goBack];
     } else {
         [self dismissViewControllerAnimated:YES completion:nil];
     }
}

@end






