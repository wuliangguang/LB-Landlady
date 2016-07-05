//
//  GLViewForScroller.h
//  LB-Landlady
//
//  Created by 露露 on 16/2/26.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLViewForScroller;
@protocol GLViewForScrollerDelegate <NSObject>

/**
 *  item 个数
 */
-(NSInteger)itemNum;

/**
 *  view自身的size
 */
-(CGSize)viewSize;

/**
 *  item 的size
 */
-(CGSize)itemSize;

/**
 *  item 的横向间距
 */
-(CGFloat)itemHorizenPin;

/**
 *  item的垂直间距
 */

-(CGFloat)itemVerticalPin;

-(UIView * )view:(GLViewForScroller *)view itemIndex:(NSInteger)item;


@end


@interface GLViewForScroller : UIView<GLViewForScrollerDelegate>

@property(nonatomic,assign)id<GLViewForScrollerDelegate> delegate;

@property(nonatomic,strong)UIScrollView * scrollerView;

-(void)reloadData;
@end
