//
//  DateCollectionCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/14.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DateCollectionCellType) {
    DateCollectionCellTypeDisable         = 0, // 不可选
    DateCollectionCellTypeEnableNotChoose = 1, // 可选：未选中
    DateCollectionCellTypeEnableDidChoose = 2  // 可选：已选中
};

@interface DateCollectionCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *button;
@property (nonatomic) DateCollectionCellType type;

@end
