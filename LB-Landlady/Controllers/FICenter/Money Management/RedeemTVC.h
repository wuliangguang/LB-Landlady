//
//  RedeemTVC.h
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/10.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsDetailModel.h"
#import "GLLabel.h"
@interface RedeemTVC : UITableViewController
@property(nonatomic,strong)ProductsDetailModel * model;

@property (strong, nonatomic) IBOutlet UILabel *productNameLab;/**<产品名称*/
@property (strong, nonatomic) IBOutlet UILabel *dayCountLab;/**<剩余天数*/
@property (strong, nonatomic) IBOutlet UILabel *ownLab;/**<持有金额*/
@property (strong, nonatomic) IBOutlet UILabel *allIncomeLab;/**<累计收入*/

@property (strong, nonatomic) IBOutlet UILabel *predicateLab;/**<预期收入*/
@property (strong, nonatomic) IBOutlet UITextField *redeemTF;/**<输入赎回金额*/

@property (strong, nonatomic) IBOutlet UILabel *amountLab;/**<可赎回金额*/
- (IBAction)redeemButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet GLLabel *attributedLab;/**<富文本lab*/


@end
