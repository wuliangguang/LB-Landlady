//
//  DateClickCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/14.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateClickCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@property(nonatomic,assign)BOOL isRed;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;
@end
