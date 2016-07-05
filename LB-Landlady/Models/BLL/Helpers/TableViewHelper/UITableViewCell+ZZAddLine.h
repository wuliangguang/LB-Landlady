//
//  UITableViewCell+ZZConvenience.h
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/15/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ZZAddLine)

/**
 *  考虑到系统中有很多自定义cell的分隔线（不用系统cell自带线的情况，统一封装，当此属性为YES时，显示自定义的线）
 */
@property (nonatomic) BOOL showCustomLine;
@end
