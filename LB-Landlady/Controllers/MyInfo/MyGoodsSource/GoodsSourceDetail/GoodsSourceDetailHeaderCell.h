//
//  GoodsSourceDetailHeaderCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSourceDetailDataModel.h"

@interface GoodsSourceDetailHeaderCell : UITableViewCell

@property (nonatomic) GoodSourceDetailDataModel *dataModel;

/**
 *  数量改变回调
 */
@property (nonatomic, copy) block_void_t numDidChangeCallback;

/**
 *  用户输入的数量
 */
- (NSInteger)inputNum;


@end
