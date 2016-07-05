//
//  GLViewForScroller.m
//  LB-Landlady
//
//  Created by 露露 on 16/2/26.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "GLViewForScroller.h"

@interface GLViewForScroller ()

@end

@implementation GLViewForScroller


-(instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.scrollerView];
        self.scrollerView.pagingEnabled = YES;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollerView];
        self.scrollerView.pagingEnabled = YES;
    }
    return self;
}

-(void)reloadData
{
    NSInteger itemNum = [self.delegate itemNum];
    
    CGSize viewSize = [self.delegate viewSize];
    
    CGSize itemSize = [self.delegate itemSize];
    
    CGFloat horizenPin = [self.delegate itemHorizenPin];
    
    CGFloat verticalPin = [self.delegate itemVerticalPin];
    
    self.scrollerView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    self.scrollerView.contentSize = CGSizeMake(ceil(itemNum/4.0)*viewSize.width, viewSize.height);
    
    CGFloat itemX=0,itemY=0;
    //利用for循环在scrollerview上创建itemnum个view
    for (int  i = 0 ; i<itemNum ; i++)
    {
        UIView * view = [self.delegate view:self itemIndex:i];
        //当前的大区
        NSInteger bigIndex = i/4;//ceil(i/4.0);[0,1,2,3,4.....]
        
        //小的item在大区里面的index
        NSInteger smallIndex = i%4;//[0,1,2,3]
        
        //先确定大区的位置，在加上小区里的位置，就可定位
        itemX = bigIndex * viewSize.width + smallIndex%2*(itemSize.width+horizenPin);
        
        itemY = smallIndex/2 *(itemSize.height + verticalPin);
        
        view.frame = CGRectMake(itemX, itemY, itemSize.width, itemSize.height);
        [self.scrollerView addSubview:view];
    }
}

-(UIScrollView *)scrollerView
{
    if (_scrollerView == nil) {
        _scrollerView = [[UIScrollView alloc]init];
    }
    return _scrollerView;
}

@end
