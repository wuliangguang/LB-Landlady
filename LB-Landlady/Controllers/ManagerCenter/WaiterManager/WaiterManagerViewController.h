//
//  WaiterManagerViewController.h
//  MeZoneB_Bate
//
//  Created by  on 15/11/23.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaiterManagerViewController : UIViewController<UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic)UITableView *tableView;
@end
