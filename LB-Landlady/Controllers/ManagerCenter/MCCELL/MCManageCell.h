//
//  MCManageCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCManageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;
@property(nonatomic,copy)void(^productBtnBlock)();
@property(nonatomic,copy)void(^waiterBtnBlock)();
@end
