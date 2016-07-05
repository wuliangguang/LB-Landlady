//
//  EditVIPMakeTVC.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"
#import "VipModel.h"

@interface EditVIPMakeTVC : UITableViewController
@property(nonatomic,assign)BOOL isChange;
@property (strong, nonatomic) IBOutlet UITextField *vipRateTF;
@property (strong, nonatomic) IBOutlet UITextField *privilgeTF;
@property (strong, nonatomic) IBOutlet UITextField *needCostTf;
@property (strong, nonatomic) IBOutlet SZTextView *introduceTFView;
@property (strong, nonatomic) IBOutlet UISwitch *switchOn;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)VipModel * model;
@property(nonatomic,strong)VipModel * defaultModel;
@property(nonatomic,copy)void(^editSuccess)();
@end
