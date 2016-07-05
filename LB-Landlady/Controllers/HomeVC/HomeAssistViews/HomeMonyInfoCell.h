//
//  HomeMonyInfoCell.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDataModel.h"

@interface HomeMonyInfoCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t callbackHandler;

@property (nonatomic) IncomeDataModel *income;
@end
