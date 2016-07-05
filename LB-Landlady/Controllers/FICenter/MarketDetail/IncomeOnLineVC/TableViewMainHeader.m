//
//  TableViewMainHeader.m
//  MeZoneB_Bate
//
//  Created by d2space on 15/9/21.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "TableViewMainHeader.h"

@implementation TableViewMainHeader

- (IBAction)clickMoreBtnMethod:(UIButton *)sender
{
    if (self.moreBtn.selected == NO)
    {
        self.moreBtn.selected = YES;
    }
    else
    {
        self.moreBtn.selected = NO;
    }
    self.clickMoreBtn(self.moreBtn);
}

@end
