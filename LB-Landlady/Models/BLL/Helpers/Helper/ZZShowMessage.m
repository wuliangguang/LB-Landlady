//
//  ToastMessage.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

NSString * const s_phone_error             = @"手机号码输入错误";
NSString * const s_verify_code_error       = @"验证码输入错误";
NSString * const s_password_error          = @"密码输入错误";
NSString * const s_confirm_password_error  = @"输入密码不一致";
NSString * const s_modify_password_success = @"修改密码成功";
NSString * const s_modify_password_fail    = @"修改密码失败";

/**
 *  广告
 */
NSString * const s_ad_home             = @"0"; // 首页
NSString * const s_ad_my_merchant      = @"1"; // 我的货源
NSString * const s_ad_service          = @"2"; // 服务商城
NSString * const s_ad_financial        = @"3"; // 财务室
NSString * const s_ad_financial_manage = @"4"; // 理财
NSString * const s_ad_manage_center    = @"5"; // 管理中心

/**
 *  web介绍页面
 */
NSString * const s_web_type_clerk                 = @"clerk";
NSString * const s_web_type_finance               = @"finance";
NSString * const s_web_type_financialTransactions = @"financialTransactions";
NSString * const s_web_type_manage                = @"manage";
NSString * const s_web_type_material              = @"material";
NSString * const s_web_type_mySource              = @"mySource";
NSString * const s_web_type_news                  = @"news";
NSString * const s_web_type_other                 = @"other";
NSString * const s_web_type_product               = @"product";
NSString * const s_web_type_server                = @"server";
NSString * const s_web_type_shops                 = @"shops";
NSString * const s_web_type_source                = @"source";
NSString * const s_web_type_store                 = @"store";
NSString * const s_web_type_sweep                 = @"sweep";
NSString * const s_web_type_trade                 = @"trade";
NSString * const s_web_type_vip                   = @"vip";

// 极光推送app key
NSString * const s_jpush_app_key = @"3b07d0c76df0d403d09274e4";
NSString * const s_jpush_app_secret = @"6ab8d8d49029c1462555f69c";

// 总收入通知
NSString *const s_notification_income_change = @"IncomeChangeNotification";

/**
 *  店铺扫描支付的二维码
 */
//http://pay.xylbn.cn/
NSString *const s_backOffPath = @"http://pay.xylbn.cn/weixin/toOrderPay?";
//NSString *const s_oauthPath = @"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxabedbe43ebfe879d&redirect_uri=";
NSString *const s_centerPath = @"state=";
NSString *const s_wecchatPath = @"&businessName=";
NSString *const s_key = @"d2a57dc1d883fd21fb9951699df71cc7";
