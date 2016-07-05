//
//  TMButtonCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/14.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TMButtonCell : UITableViewCell

@property(nonatomic,copy) void(^buttonClickBlock)(NSInteger buttonClickBlock );

@end
