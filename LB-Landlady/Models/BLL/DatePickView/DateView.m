//
//  DateView.m
//  demo
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "DateView.h"
#import "NSDate+Helper.h"



@implementation DateView
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LD_COLOR_THIRTEEN;
        typeof(self)safeSelf = self;
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil]lastObject];
//        _headerView.backgroundColor = LD_COLOR_TWELVE;
        _headerView.frame = CGRectMake(0, 0, self.frame.size.width, 40);
        _headerView.right.hidden = YES;
        _headerView.moreBtnBlock = ^(HeaderView * header,BOOL isTap){
            [header.moreBtn setImage:[UIImage imageNamed: @"top"] forState:UIControlStateNormal];
            safeSelf.maskViewAnimation(header,isTap);
        };
        [self addSubview:_headerView];
        _yearAndMonth = [[NSDate date] toStringWithFormat:@"yyyy-MM"];
        _selectIndex = 1;
        _headerView.leftBtnBlock = ^(NSInteger selectNum,NSInteger year,NSInteger month,NSInteger day)
        {
            safeSelf.yearAndMonth = [NSString stringWithFormat:@"%d-%d",year,month];
             safeSelf.headerView.timeLab.text = [NSString stringWithFormat:@"%@-%d",self.yearAndMonth,self.selectIndex];
            if (safeSelf.buttonView != nil)
            {
                safeSelf.buttonView.selectedNum = selectNum;
            }
            else
            {
                [safeSelf initButtonView];
                 safeSelf.buttonView.selectedNum = selectNum;
            }
            
        };
    }
    return self;
}
-(void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    _headerView.timeLab.text = _dateStr;
}
- (void)initButtonView
{
    __weak typeof(self) weakSelf = self;
    _buttonView =[[ButtonView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 40)];
    _buttonView.buttonIndexClickBlock = ^(NSInteger num){
        weakSelf.headerView.timeLab.text = [NSString stringWithFormat:@"%@-%2d",weakSelf.yearAndMonth,num];
        if (weakSelf.dayBtnClick) {
            weakSelf.dayBtnClick(weakSelf.headerView.timeLab.text);
        }
    };
}
-(void)setStyle:(ViewStyle)style
{
    _style = style;
    _headerView.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height-10);
    if (_buttonView) {
        [_buttonView removeFromSuperview];
        _buttonView = nil;
    }
    if (_startAndEndTimeView) {
        [_startAndEndTimeView removeFromSuperview];
        _startAndEndTimeView = nil;
    }
    switch (_style) {
        case ViewStyle_Day:
        {
            if (_buttonView == nil)
            {
                [self initButtonView];
            }
            [self addSubview:_buttonView];
        }
            break;
        case 1:
        {
            self.frame = CGRectMake(0, 0, self.frame.size.width, 40);
            self.backgroundColor = [UIColor whiteColor];

        }
            break;
        case ViewStyle_TwoBtn:
        {
            __weak typeof(self) weakSelf = self;
            if (_startAndEndTimeView == nil)
            {
                _startAndEndTimeView=[[[NSBundle mainBundle] loadNibNamed:@"StartEndView" owner:self options:nil]lastObject];
                _startAndEndTimeView.frame = CGRectMake(0, 40, self.frame.size.width, 60);
                _startAndEndTimeView.BtnBlock=^(StartEndView * startEndView,TIMETYPE type){
                    weakSelf.BtnBlock(startEndView,type);
                };
            }
            [self addSubview:_startAndEndTimeView];
        }
            break;
            
        default:
            break;
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
