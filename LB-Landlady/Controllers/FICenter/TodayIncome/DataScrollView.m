//
//  DataScrollView.m
//  LinkTown
//
//  Created by 喻晓彬 on 15/11/16.
//  Copyright © 2015年 d2space. All rights reserved.
//

#import "DataScrollView.h"
#import "FileUtil.h"

@interface DataScrollView()
@property (nonatomic,strong)    UIScrollView *scrollView;/**<scrollerView*/
@property (nonatomic,strong)    UILabel *yearlabel;/**<显示的label*/
@property (nonatomic,assign)    NSInteger curYear;/**<现在的年份*/
@property (nonatomic,strong)    NSString *curMonth;/**<现在的月份*/
@property (nonatomic,strong)    NSString *curDay;/**<现在的日期*/
@property (nonatomic,assign)    NSInteger daysCount;/**<表示的是一个月几天，还是一年几个月*/
//buttonCounts
@property (nonatomic,assign)    NSInteger currenttime;/**现在的月或者天*/

@end

@implementation DataScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//         [self showUI];
        
    }
    return self;
}
-(void)setFromVC:(FROM)fromVC
{
    _fromVC = fromVC;
    [self showUI];
}
- (void)showUI
{
    self.yearlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.yearlabel.textAlignment = NSTextAlignmentCenter;
    self.yearlabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.yearlabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, self.frame.size.width, 1)];
    line.backgroundColor = [HEXColor getColor:@"#e3e3e3"];
    [self.yearlabel addSubview:line];
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 39)];
    self.scrollView.backgroundColor = [HEXColor getColor:@"#fbfbfb"];
    [self addSubview:self.scrollView];
    
    UILabel *bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 79, kScreenWidth, 1)];
    bottomLine.backgroundColor = [HEXColor getColor:@"#e3e3e3"];
    [self addSubview:bottomLine];
    
    
    if (self.fromVC == FROM_Trade) {
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 10, 60, 30);
        [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setImage:[UIImage imageNamed: @"left"] forState:UIControlStateNormal];
        [self.yearlabel addSubview:leftBtn];
        
        
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(kScreenWidth - 60, 10,60, 30);
        [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setImage:[UIImage imageNamed: @"right"] forState:UIControlStateNormal];
        [self.yearlabel addSubview:rightBtn];
        
        
    }
    NSDate *curDate  =[NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *com = [cal components: NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:curDate];
    com.hour = 0 ;
    com.minute = 0;
    com.second = 0;

    self.curYear = com.year;//[NSString stringWithFormat:@"%lu年",(long)com.year];
    self.curMonth = [NSString stringWithFormat:@"%lu",(long)com.month];
    self.curDay = [NSString stringWithFormat:@"%lu",(long)com.day];
    
    if (self.fromVC == FROM_DayOnline||self.fromVC == FROM_Trade)
    {
        _daysCount = [FileUtil howManyDaysInThisYear:com.year month:com.month];
        _currenttime = com.day;
    }
#warning
    else if (self.fromVC == FROM_Finacial)
    {
        _daysCount = 12;
        _currenttime = com.month;
    }
#warning
    else
    {
        _daysCount = 12;
        _currenttime = com.month;
    }
    
    for (int i = 1; i < _daysCount+1; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(14 + 50 * (i- 1), 5, 30, 30);
        button.tag = 3333 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i <= _currenttime)
        {
            if (button.tag == 3333 + _currenttime)
            {
                button.backgroundColor = [UIColor redColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor redColor].CGColor;

            }
            else
            {
                [button setTitleColor:[HEXColor getColor:@"ff3c25"] forState:UIControlStateNormal];
                button.layer.borderColor = [HEXColor getColor:@"#efefef"].CGColor;
                button.backgroundColor = [UIColor clearColor];
            }
            
        }
        else
        {
            [button setTitleColor:[HEXColor getColor:@"#ededed"] forState:UIControlStateNormal];
            button.layer.borderColor = [HEXColor getColor:@"#efefef"].CGColor;
            button.backgroundColor = [UIColor clearColor];
             button.enabled = NO;
        }
        [button setTitle: [NSString stringWithFormat:@"%02d",i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 15;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 2;
        [self.scrollView addSubview:button];
        
    }
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(14 + 50 * _daysCount , 39);

    if (_fromVC == FROM_DayOnline)
    {
        self.yearlabel.text  = @"今天";
    }
    else if (_fromVC == FROM_Finacial)
    {
        self.yearlabel.text  = [NSString stringWithFormat:@"%lu年",(long)com.year];
    }
    else
    {
        self.yearlabel.text  = [NSString stringWithFormat:@"%lu月",(long)com.month];
    }
    if (_currenttime * 50 +14 > kScreenWidth +10)
    {
       self.scrollView.contentOffset = CGPointMake((_currenttime)* 50 +14 - kScreenWidth, 0);
    }
}
#pragma mark ------ButtonClick------
- (void)buttonClick:(UIButton *)button
{
    for ( int i = 1; i < _daysCount+1; i ++)
    {
        UIButton * allbutton  = (UIButton *)[self viewWithTag:i + 3333];
        allbutton.backgroundColor = [UIColor clearColor];
        allbutton.enabled = YES;
        allbutton.layer.borderColor = [HEXColor getColor:@"#efefef"].CGColor;
        [allbutton setTitleColor:[HEXColor getColor:@"ff3c25"] forState:UIControlStateNormal];
        if (i > _currenttime)
        {
            allbutton.enabled = NO;
            [allbutton setTitleColor:[HEXColor getColor:@"#ededed"] forState:UIControlStateNormal];
        }
        
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [HEXColor getColor:@"ff3c25"];
    button.layer.borderColor = [HEXColor getColor:@"ff3c25"].CGColor;
    NSInteger month = button.tag - 3333;
    if (_fromVC == FROM_DayOnline)
    {
        self.yearlabel.text = [NSString stringWithFormat:@"%@月%ld日",_curMonth,(long)month];
        if (month == _currenttime)
        {
            self.yearlabel.text = @"今天";
        }
        
        self.ChangeDateWhenClickButton([NSString stringWithFormat:@"%02ld",(long)month],[_curMonth integerValue]);
    }else if (_fromVC == FROM_Finacial)
    {
        self.yearlabel.text = [NSString stringWithFormat:@"%ld年",(long)self.curYear];
        self.ChangeDateWhenClickButton([NSString stringWithFormat:@"%02ld",(long)month],_curYear);
    }
    else
    {
        self.yearlabel.text = [NSString stringWithFormat:@"%ld月",(long)month];
        self.ChangeDateWhenClickButton([NSString stringWithFormat:@"%02ld",(long)month],_curYear);
    }
}
-(void)rightBtnClick:(UIButton *)button
{
    
}

-(void)leftBtnClick:(UIButton *)button
{
    
}
@end
