//
//  ZZBadgeView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZBadgeView.h"

@implementation ZZBadgeView

- (void)awakeFromNib {
    dispatch_async(dispatch_get_main_queue(), ^{
         [self setUp];
    });
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor redColor];
    self.textColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.width/2.0f;
    [self setClipsToBounds:YES];
}

- (void)setBadgeValue:(NSInteger)badgeValue {
    _badgeValue = badgeValue;
    if (_badgeValue <= 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        self.text = [NSString stringWithFormat:@"%@", badgeValue > 99 ? @"99+" : [NSString stringWithFormat:@"%ld", badgeValue]];
    }
}

@end

