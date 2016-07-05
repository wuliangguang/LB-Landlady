//
//  UITableView+ZZHiddenExtraLine.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/9/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "UITableView+ZZHiddenExtraLine.h"

@implementation UITableView (ZZHiddenExtraLine)

- (void)hiddenExtraLine {
    self.tableFooterView = [[UIView alloc] init];
}

@end
