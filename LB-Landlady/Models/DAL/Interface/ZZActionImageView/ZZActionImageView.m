//
//  ZZActionImageView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZActionImageView.h"

@interface ZZActionImageView ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@end

@implementation ZZActionImageView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        self.userInteractionEnabled = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)addTarget:(id)target forSelector:(SEL)selector {
    self.target = target;
    self.selector = selector;
}

@end
