//
//  MyGoodsSourceShopOptionCell.h
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryModel.h"

@interface MyGoodsSourceShopOptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;
@property (nonatomic) IndustryModel *industryModel;
@end
