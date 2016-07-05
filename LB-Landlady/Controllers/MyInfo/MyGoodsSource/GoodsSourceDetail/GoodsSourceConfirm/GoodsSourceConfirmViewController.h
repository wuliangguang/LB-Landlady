//
//  GoodsSourceConfirmViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSourceDetailDataModel.h"

@interface GoodsSourceConfirmViewController : UITableViewController

@property (nonatomic) GoodSourceDetailDataModel *dataModel;
@property (nonatomic) ProductPriceItem *choosedPriceItem;
@end
