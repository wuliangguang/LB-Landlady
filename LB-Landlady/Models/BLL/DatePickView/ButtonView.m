//
//  ButtonView.m
//  demo
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "ButtonView.h"
#import "DateCollectionCell.h"
#import "HEXColor.h"
#import "FileUtil.h"

@interface ButtonView ()

@property(nonatomic)NSInteger curYear;
@property(nonatomic)NSInteger curMonth;

@end

@implementation ButtonView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super  initWithFrame:frame]) {
        NSDate *curDate  =[NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *com = [cal components: NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:curDate];
        
        _curYear = com.year;
        _curMonth = com.month;
        _criticalValue = com.day;
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(30, 30);
        
        flowLayout.minimumInteritemSpacing= 8;
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor =[HEXColor getColor:@"#fbfbfb"];
        [_collectionView registerNib:[UINib nibWithNibName:@"DateCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"DateCollectionCell"];
        [self addSubview:_collectionView];
        self.backgroundColor =[UIColor redColor];
    }
    return self;
}

- (void)setSelectedNum:(NSInteger)selectedNum
{
    _selectedNum = selectedNum;
    [self.collectionView reloadData];
}
#pragma mark -------Delegate --------
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DateCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCollectionCell" forIndexPath:indexPath];
    cell.button.text = [NSString stringWithFormat:@"%0td",indexPath.row +1];
    
    //刷新的时候和加载cell的时候判断cell的indexpath和临界值的大小关系，对应的改变状态
    NSInteger compareNum = indexPath.row + 1;
    
    if (_selectedNum == 0)
    {
        if (compareNum > _criticalValue)
        {
            cell.type = DateCollectionCellTypeDisable;
        }
        else
        {
            if (_selectedIndexPath == nil)
            {
                if (compareNum == _criticalValue)
                {
                    cell.type = DateCollectionCellTypeEnableDidChoose;
                }
                else
                {
                    cell.type = DateCollectionCellTypeEnableNotChoose;
                }
            }
            else
            {
                if (indexPath.row   == _selectedIndexPath.row)
                {
                    cell.type = DateCollectionCellTypeEnableDidChoose;
                }
                else
                {
                    cell.type = DateCollectionCellTypeEnableNotChoose;
                }
            }
        }
    }
    else
    {
        if (_selectedIndexPath.row != indexPath.row)
        {
            cell.type = DateCollectionCellTypeEnableNotChoose;
        }
        else
        {
            cell.type = DateCollectionCellTypeEnableDidChoose;
        }
        
    }
    
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [FileUtil howManyDaysInThisYear:_curYear month:_curMonth];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMLog(@"%td",indexPath.row +1);
    self.buttonIndexClickBlock(indexPath.row+1);
    DateCollectionCell *cell = (DateCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.type != DateCollectionCellTypeDisable) {
        self.selectedIndexPath = indexPath;
//        _criticalValue = indexPath.row +1;
        [self.collectionView reloadData];
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
