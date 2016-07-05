//
//  StartEndView.m
//  demo
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "StartEndView.h"
#import "NSDate+Escort.h"

@implementation StartEndView



-(void)awakeFromNib
{
    NSString * nowStr = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
    [self.endTime setTitle:nowStr forState:UIControlStateNormal];
    [self.startTime setTitle:nowStr forState:UIControlStateNormal];
}

- (IBAction)startBtnClick:(id)sender {
    
    self.BtnBlock(self,TIMETYPE_START);
}
- (IBAction)endTimeBtnClick:(id)sender {
    self.BtnBlock(self,TIMETYPE_END);
}
@end
