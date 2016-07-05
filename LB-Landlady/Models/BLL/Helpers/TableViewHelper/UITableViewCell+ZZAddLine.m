//
//  UITableViewCell+ZZConvenience.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/15/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "UITableViewCell+ZZAddLine.h"
#import "NSObject+Helper.h"

@implementation UITableViewCell (ZZAddLine)

- (void)setShowCustomLine:(BOOL)showCustomLine {
    self.attachObject = [NSNumber numberWithBool:showCustomLine];
}

- (BOOL)showCustomLine {
    
    return [self.attachObject boolValue];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.showCustomLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, LD_COLOR_THIRTEEN.CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, 0, CGRectGetMaxY(rect)-1);
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)-1);
        CGContextStrokePath(context);
        // CGContextStrokePath(context);
    }
}

@end
