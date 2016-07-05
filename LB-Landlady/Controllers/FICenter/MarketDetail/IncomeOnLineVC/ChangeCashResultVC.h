//
//  ChangeCashResultVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/10/28.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeOnlineViewController.h"

@interface ChangeCashResultVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, assign)IncomeType       incomeType;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UIButton *bindbtn;
@property (strong, nonatomic) IBOutlet UIButton *submitbtn;
@property (strong, nonatomic) IBOutlet UITableView *cardTableView;
@property (nonatomic , assign) BOOL isBind ;
//@property(nonatomic,assign)NSString *
@property(nonatomic,assign)float totalMoney;


@end
