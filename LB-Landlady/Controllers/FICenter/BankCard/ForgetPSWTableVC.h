//
//  ForgetPSWTableVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/18.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPSWTableVC : UITableViewController
@property (strong, nonatomic) IBOutlet UIButton *smsBtn;
@property (strong, nonatomic) IBOutlet UITextField *bankNumTF;
@property (strong, nonatomic) IBOutlet UITextField *sureCodeTF;
@property(nonatomic,assign)int timeout;
@end
