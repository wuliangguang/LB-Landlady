//
//  WaiterInfoTableVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiterListModel.h"
#import "ChangeInfoTableVC.h"

@interface WaiterInfoTableVC : UITableViewController<UIActionSheetDelegate>
@property(nonatomic,strong)WaiterListModel * model;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *position;
@property (strong, nonatomic) IBOutlet UITableViewCell *section1Cell;

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;

// 修改店员
@property (nonatomic, copy) void (^callbackHandler)(WaiterListModel *model);

@end
