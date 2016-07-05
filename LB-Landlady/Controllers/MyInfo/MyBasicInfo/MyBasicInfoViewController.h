//
//  MyBasicInfoViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/14/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBasicInfoViewController : UITableViewController
/** Models */
@property (nonatomic) MyInfoDataModel *dataModel;
@property (nonatomic, copy) block_id_t callbackHandler;

@end
