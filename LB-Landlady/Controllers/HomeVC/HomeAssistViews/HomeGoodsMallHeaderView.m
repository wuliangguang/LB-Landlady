//
//  HomeGoodsMallHeaderView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomeGoodsMallHeaderView.h"

@implementation HomeGoodsMallHeaderView

- (IBAction)more:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
