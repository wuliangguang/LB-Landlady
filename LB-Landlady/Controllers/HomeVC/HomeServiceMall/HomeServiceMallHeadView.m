//
//  HomeServiceMallHeadView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/25/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomeServiceMallHeadView.h"
#define kIndicatorViewHeight 2.0

@interface HomeServiceMallHeadView ()

@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) UIButton *selectedButton;
@property (nonatomic) UIView *indicatorView;
@end

@implementation HomeServiceMallHeadView

- (void)setItems:(NSArray *)items {
    self.buttons = [NSMutableArray arrayWithCapacity:items.count];
    CGFloat buttonWidth = self.frame.size.width/items.count;
    CGFloat buttonHeight = self.frame.size.height-kIndicatorViewHeight;
    for (NSInteger i = 0; i < items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, buttonHeight);
        [button setTitleColor:LD_COLOR_TEN forState:UIControlStateNormal];
        // button.backgroundColor = [UIColor cyanColor];
        [button setTitleColor:LD_COLOR_ONE forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setTintColor:[UIColor clearColor]];
        [button setTitle:items[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        [self addSubview:button];
    }
    
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonHeight, buttonWidth, kIndicatorViewHeight)];
    self.indicatorView.backgroundColor = LD_COLOR_ONE;
    [self addSubview:self.indicatorView];
    
    self.selectedButton = self.buttons[0];
}

- (void)buttonClick:(UIButton *)button {
    self.selectedButton = button;
}

- (void)setSelectedButton:(UIButton *)selectedButton {
    if (selectedButton != self.selectedButton) {
        _selectedButton = selectedButton;
        for (UIButton *button in self.buttons) {
            button.selected = button == _selectedButton ? YES : NO;
        }
        CGRect frame = self.indicatorView.frame;
        frame.origin.x = _selectedButton.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.frame = frame;
        }];
        if (self.callbackHandler) {
            self.callbackHandler(_selectedButton, [self.buttons indexOfObject:_selectedButton]);
        }
    }
}

@end
