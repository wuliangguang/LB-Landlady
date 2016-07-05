//
//  ViewForGL.m
//  LB-Landlady
//
//  Created by 露露 on 16/3/1.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ViewForGL.h"

@implementation ViewForGL

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        _iconImageview.layer.cornerRadius = _iconImageview.frame.size.width/2.0;
//        _iconImageview.clipsToBounds = YES;
//    });
    
}

- (IBAction)buttonClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (_buttonClickBlock) {
        _buttonClickBlock(btn.tag);
    }
}
@end
