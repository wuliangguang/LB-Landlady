//
//  ItemTitleButtonListView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ItemTitleButtonListView.h"
#import "ItemTitleButton.h"
#import "NSObject+Helper.h"

@implementation ItemTitleButtonListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.items = [NSMutableArray array];
    NSUInteger count = 4;
    CGFloat padding  = 1.0f;
    CGFloat width    = (self.bounds.size.width-(count+1)*padding)/count;//self.items.count;
    CGFloat height   = self.bounds.size.height;
    for (NSInteger i = 0; i < count; i++) {
        ItemTitleButton *titleButton = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ItemTitleButton class]) owner:nil options:nil] firstObject];
        titleButton.frame            = CGRectMake(padding+(padding+width)*i, 0, width, height);
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleButton];
        [self.items addObject:titleButton];
        
        // 分隔线
        if (i < count - 1) {
            CGFloat margin = 20;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleButton.frame), margin, 1, height-margin)];
            lineView.backgroundColor = LD_COLOR_FOURTEEN;
            [self addSubview:lineView];
        }
    }
}

- (void)titleButtonClick:(ItemTitleButton *)button {
    if (self.callbackHandler) {
        self.callbackHandler(button.attachObject);
    }
}

@end
