//
//  SwitchPage.h
//  SwitchPage
//
//  Created by d2space on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TestModel.h"
#import "VipAddModel.h"

@interface SwitchPage : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, copy) void (^selectedModel)(id model);
@property (nonatomic, copy) void (^tableViewHeaderMethod)(NSInteger index);
@property (nonatomic, copy) void (^tableViewFooterMethod)(NSInteger index,NSInteger pageCount);
@property(nonatomic,copy)void(^indexSelected)(NSInteger topIndex);
- (instancetype)initWithFrame:(CGRect)frame;

@end
