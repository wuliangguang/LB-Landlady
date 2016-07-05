//
//  UITabBar+ZZCustomBadge.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/25/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "UITabBar+ZZCustomBadge.h"
#define kDefaultTabItemIndex 3

@implementation UITabBar (CustomBadge)

static NSMutableArray *_badgeArray;

- (void)showBadge {
    [self showBadgeOnItemOfIndex:kDefaultTabItemIndex];
}

- (void)showBadgeOnItemOfIndex:(NSInteger)index {
    UIView *badgeView = [self.badgeArray objectAtIndex:index];
    badgeView.hidden  = NO;
}

- (void)hideBadge {
    [self hideBadgeOnItemOfIndex:kDefaultTabItemIndex];
}

- (void)hideBadgeOnItemOfIndex:(NSInteger)index {
    UIView *badgeView = [self.badgeArray objectAtIndex:index];
    badgeView.hidden = YES;
}

- (NSArray *)badgeArray {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect tabFrame         = self.frame;
        CGFloat badgeViewLength = 10.0f;
        CGFloat itemLength      = tabFrame.size.width/self.items.count;
        NSUInteger count        = self.items.count;
        _badgeArray             = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger i = 0; i < count; i++) {
            UIView *badgeView            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, badgeViewLength, badgeViewLength)];
            badgeView.backgroundColor    = [UIColor redColor];
            badgeView.layer.cornerRadius = badgeViewLength/2.0;
            CGFloat originX              = itemLength*(i+1)-itemLength/3.0;
            CGFloat originY              = badgeViewLength/2.0;
            CGRect frame                 = badgeView.frame;
            frame.origin.x               = originX;
            frame.origin.y               = originY;
            badgeView.frame              = frame;
            badgeView.hidden            = YES;
            _badgeArray[i] = badgeView;
            [self addSubview:badgeView];
        }
    });
    return _badgeArray;
}

@end