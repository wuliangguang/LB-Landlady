//
//  MCenterViewController.h
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLViewForScroller.h"
#import "LoginManager.h"
#import "MerchantInfoManager.h"
@interface MCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GLViewForScrollerDelegate,LoginManagerProtocol,MerchantInfoManagerProtocol>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end
