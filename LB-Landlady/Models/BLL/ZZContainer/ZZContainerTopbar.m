//
//  Topbar.m
//  ContainerDemo
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 WeiZhenLiu. All rights reserved.
//

#import "ZZContainerTopbar.h"

@interface ZZContainerTopbar ()

@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation ZZContainerTopbar

- (void)setTitles:(NSMutableArray *)titles {
    self.showsHorizontalScrollIndicator = NO;
    _titles         = titles;
    self.buttons    = [NSMutableArray array];
    CGFloat padding = 20.0;
    // CGSize contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    CGFloat originX = 0;
    for (int i = 0; i < titles.count; i++) {
        if ([_titles[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        // buttons
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:_titles[i] forState:UIControlStateNormal];

        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        // set button frame
        // static CGFloat originX = 0;
        // 不能写为static, static修饰的变量在当前对象消失时并不消失，所以导致这个东西一直存在，当多次新建当前对象时，这个值依然保留着最原始的值
        CGRect frame = CGRectMake(originX+padding, 0, button.intrinsicContentSize.width, kTopbarHeight);
        button.frame = frame;
        originX      = CGRectGetMaxX(frame) + padding;
        
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.buttons.lastObject frame]) + padding, self.frame.size.height);
    NSLog(@"content_size_width:--> %lf", self.contentSize.width);
    
    // mark view
    UIButton *firstButton = self.buttons.firstObject;
    CGRect frame = firstButton.frame;
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(frame)-3, frame.size.width, 3)];
    _markView.backgroundColor = [UIColor redColor];
    [self addSubview:_markView];
}

- (void)buttonClick:(id)sender {
    self.currentPage = [self.buttons indexOfObject:sender];
    if (_callbackHandler) {
        _callbackHandler(_currentPage);
    }
}

// overwrite setter of property: selectedIndex
- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    for (UIButton *b in _buttons) {
        [b setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    UIButton *button = [_buttons objectAtIndex:_currentPage];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGRect frame = button.frame;
    frame.origin.x -= 5;
    frame.size.width += 10;
    [self scrollRectToVisible:frame animated:YES];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.markView.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame)-3, button.frame.size.width, 3);
    } completion:nil];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
