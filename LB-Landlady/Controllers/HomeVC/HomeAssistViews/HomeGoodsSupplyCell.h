//
//  HomeGoodsSupplyCell.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTitleButtonListView.h"
#import "GoodSourceProductDataModel.h"

@interface HomeGoodsSupplyCell : UITableViewCell

@property (nonatomic) GoodSourceProductDataModel *productDataModel;
@property (nonatomic, copy) block_id_t callbackHandler;
@end
