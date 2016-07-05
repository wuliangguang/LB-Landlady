//
//  InfoWebViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface InfoWebViewController : UIViewController
@property (nonatomic      ) NSString   *urlStr;
@property (nonatomic, copy) block_id_t callbackHandler;

/**
 *  此属性如果是YES(表示此控制器仅用来显示数据，和登录逻辑无关), 导航条右上角没有“登录”按钮，否则，如果用户没有登录，则显示登录按钮，如果已登录，则登录按钮不显示
 */
@property (nonatomic) BOOL showOnly;

@end
