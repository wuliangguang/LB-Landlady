//
//  UITabBar+ZZCustomBadge.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/25/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (ZZCustomBadge)

/**
 *  显示小红点
 */
- (void)showBadge;
- (void)showBadgeOnItemOfIndex:(NSInteger)index;

/**
 *  隐藏小红点
 */
- (void)hideBadge;
- (void)hideBadgeOnItemOfIndex:(NSInteger)index;

@end
