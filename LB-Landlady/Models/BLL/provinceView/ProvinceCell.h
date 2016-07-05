//
//  ProvinceCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/29.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProinceModel.h"
@interface ProvinceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
- (void)updateModel:(ProinceModel *)model;
@end
