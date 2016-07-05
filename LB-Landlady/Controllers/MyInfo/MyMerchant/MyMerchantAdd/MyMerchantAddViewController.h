//
//  MyMerchantAddViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMerchantDataModel.h"

@interface MyMerchantAddViewController : UITableViewController

/**
 *  第一次新增店铺成功，获取店铺列表
 */
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (nonatomic, copy) block_id_t callbackHandler;
@end
