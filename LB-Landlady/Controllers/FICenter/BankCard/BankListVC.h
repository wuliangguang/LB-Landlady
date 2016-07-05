//
//  BankListVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/3.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankNameModel.h"
#import "CardInfoViewController.h"

typedef void(^ReturnStr)(BankNameModel * bankModel);

@interface BankListVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *bankListTableView;
@property(nonatomic,strong)UIViewController * infoVC;
@property(nonatomic,copy)ReturnStr strBlock;
@end
