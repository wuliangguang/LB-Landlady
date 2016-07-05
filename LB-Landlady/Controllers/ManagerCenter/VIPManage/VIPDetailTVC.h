//
//  VIPDetailTVC.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipAddModel.h"

@interface VIPDetailTVC : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *vIPIDTF;
@property (strong, nonatomic) IBOutlet UITextField *nickNameTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *vipRandTF;


@property(nonatomic,copy)void(^successBlock)();
@property(nonatomic,copy)void(^deltSuccessBlock)();
@property(nonatomic,strong)VipAddModel * model;
@end
