//
//  MyMerchantAddressViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

@interface MyMerchantAddressViewController : UIViewController

@property (nonatomic, copy) block_id_t callbackHandler;

/**
 *  修改，如果此字段为YES, 代表修改商铺地址，否则表示新增商铺地址
 */
@property (nonatomic) BOOL modify;
@end
