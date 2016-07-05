//
//  Topbar.h
//  ContainerDemo
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 WeiZhenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTopbarHeight 35

typedef void (^ButtonClickHandler)(NSInteger currentPage);

@interface ZZContainerTopbar : UIScrollView

@property (nonatomic) NSMutableArray *titles;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, copy) ButtonClickHandler callbackHandler;
@end
