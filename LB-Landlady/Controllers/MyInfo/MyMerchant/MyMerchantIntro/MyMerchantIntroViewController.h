//
//  MyMerchantIntroViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "VPViewController.h"
#import "MyBusinessInfoModel.h"

@interface MyMerchantIntroViewController : VPViewController

@property (nonatomic) MyBusinessInfoModel *merchantModel;

@property (nonatomic, copy) block_id_t callbackHandler;
@end
