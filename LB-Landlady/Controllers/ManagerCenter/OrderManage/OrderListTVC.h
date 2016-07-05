//
//  OrderListTVC.h
//  LB-Landlady
//
//  Created by 露露 on 16/3/9.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView * tableView;
@property (nonatomic ,strong) NSString *createType;//记录从什么地方进入这个类，如果是首页，则pop，如果是OrderDetailVCWithQCode页，则dismissviewcontroller

@end
