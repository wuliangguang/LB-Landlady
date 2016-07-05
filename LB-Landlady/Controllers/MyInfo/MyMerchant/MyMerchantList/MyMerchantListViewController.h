//
//  MyMerchantListViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMerchantListViewController : UIViewController

@property (nonatomic, copy) block_id_t callbackHandler;

@property (nonatomic) MerchantListItemModel *choosedMerchantItem;
@end
