//
//  HeaderView.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "HeaderView.h"
#import "NSDate+Escort.h"


@interface HeaderView ()

@property(nonatomic,assign)BOOL isTap;
@property (nonatomic,assign)    NSInteger curYear;/**<现在的年份*/
@property (nonatomic,assign)    NSInteger curMonth;/**<现在的月份*/
@property (nonatomic,assign)    NSInteger curDay;/**<现在的日期*/


@property (nonatomic,assign)    NSInteger leftCurYear;/**<现在的年份*/
@property (nonatomic,assign)    NSInteger leftcurMonth;/**<现在的月份*/
@property (nonatomic,assign)    NSInteger leftcurDay;/**<现在的日期*/


@end
@implementation HeaderView


-(void)awakeFromNib
{

    NSDate * curDate =[NSDate date];
    NSString * curDateStr = [curDate toStringWithFormat:@"yyyy-MM-dd"];
    _timeLab.text = curDateStr;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [_tapView addGestureRecognizer:tap];
    [self todayDate];
    _moreBtn.userInteractionEnabled = NO;

//    _isTap = 
}

-(void)todayDate
{
    NSDate *curDate  =[NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *com = [cal components: NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:curDate];

    
    _curYear = com.year;
    _curMonth = com.month;
    _curDay = com.day;
    
    
    _leftCurYear = com.year;
    _leftcurMonth = com.month;
    _leftcurDay = com.day;
}


#pragma mark ------ButtonClick------
- (IBAction)leftBtnClick:(id)sender {
    _btnClickNum ++;
    _right.hidden = NO;
    if (_leftcurMonth == 1) {
        _leftcurMonth = 12 ;
        _leftCurYear -- ;
    }else
    {
        _leftcurMonth --;
    }
    _timeLab.text = [NSString stringWithFormat:@"%td-%td-%02d",_leftCurYear,_leftcurMonth,1];
    
    if (_leftBtnBlock) {
        _leftBtnBlock(_btnClickNum,_leftCurYear,_leftcurMonth,1);
    }
}

- (IBAction)rightBtnClick:(id)sender {
    _btnClickNum --;
    if (_btnClickNum == 0) {
        _right.hidden = YES;
    }
        if (_leftcurMonth == 12) {
            _leftCurYear ++;
            _leftcurMonth = 1;
        }else
        {
            _leftcurMonth ++;
        }
    _timeLab.text = [NSString stringWithFormat:@"%td-%td-%02d",_leftCurYear,_leftcurMonth,1];
    if (_leftBtnBlock) {
        _leftBtnBlock(_btnClickNum,_leftCurYear,_leftcurMonth,1);
    }
}
-(void)tapGesture:(UITapGestureRecognizer * )tap
{
    _isTap = !_isTap;
    self.moreBtnBlock(self,_isTap);
    NSLog(@"Tap HeaderView");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
