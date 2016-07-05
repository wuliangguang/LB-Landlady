//
//  MyMerchantChangePhoneViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMerchantChangePhoneViewController : UITableViewController

@property (nonatomic, copy) void (^callbackHandler)(NSString *str);
@property (nonatomic, copy) NSString *phone;
@end
