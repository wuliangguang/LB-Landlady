//
//  UITableView+ZZHiddenExtraLine.h
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/9/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZZHiddenExtraLine)

/**
 *  UITableViewStyle为plain的时候，如果cell不够多，表格下面会出现一些多余的空白的线
 *  扩展解决此问题
 */
- (void)hiddenExtraLine;

@end
