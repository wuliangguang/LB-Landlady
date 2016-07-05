//
//  MyMesageBaseViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/20/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageCell.h"
#import "MyMessageDataModel.h"
#import "UIViewController+ZZContainer.h"

@interface MyMessageBaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;

+ (instancetype)viewControllerWithTitle:(NSString *)title;

- (void)didShow;

/** 编辑 */
- (void)edit;

/** 完成, 删除 */
- (void)done;

- (void)deleteSelectedCells;

@end
