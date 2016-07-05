//
//  ToastMessage.hE
//  LB-Landlady
//
//  Created by 刘威振 on 1/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const s_phone_error;
extern NSString * const s_verify_code_error;
extern NSString * const s_password_error;
extern NSString * const s_confirm_password_error;
extern NSString * const s_modify_password_success;
extern NSString * const s_modify_password_fail;

/**
 *  获取所有广告
 *  @param  type:   string	     (0:公司内部广告－首页广告，1：我的－货源 2：服务商城 3：财务室 4： 理财 5:管理中心)
 *  @return
 */
extern NSString * const s_ad_home;             // 首页
extern NSString * const s_ad_my_merchant;      // 我的货源
extern NSString * const s_ad_service;          // 服务商城
extern NSString * const s_ad_financial;        // 财务室
extern NSString * const s_ad_financial_manage; // 理财
extern NSString * const s_ad_manage_center;    // 管理中心

/**
 *  web介绍页面
 */
extern NSString * const s_web_type_clerk;                   // 店员管理
extern NSString * const s_web_type_finance; 				// 财务管理
extern NSString * const s_web_type_financialTransactions;   // 我要理财
extern NSString * const s_web_type_manage;                  // 经营收入
extern NSString * const s_web_type_material;			    // 我的资料
extern NSString * const s_web_type_mySource; 			    // 我的货源
extern NSString * const s_web_type_news;                    // 我的消息
extern NSString * const s_web_type_other;                   // 其他功能
extern NSString * const s_web_type_product;                 // 产品管理
extern NSString * const s_web_type_server;                  // 服务商城
extern NSString * const s_web_type_shops;                   // 切换商铺
extern NSString * const s_web_type_source;                  // 货源商城
extern NSString * const s_web_type_store;                   // 我的店铺
extern NSString * const s_web_type_sweep;                   // 扫一扫
extern NSString * const s_web_type_trade;                   // 交易管理
extern NSString * const s_web_type_vip;                     // 会员管理

// 极光推送
extern NSString * const s_jpush_app_key;    // app key
extern NSString * const s_jpush_app_secret; // app secret

// 总收入通知
extern NSString * const s_notification_income_change;

/**
 *  店铺扫描支付的二维码
 */

extern NSString *const s_backOffPath;
//extern NSString *const s_oauthPath;
extern NSString *const s_centerPath;
extern NSString *const s_wecchatPath;
/**
 *  数据上传下载的KEY
 */
extern NSString *const s_key;