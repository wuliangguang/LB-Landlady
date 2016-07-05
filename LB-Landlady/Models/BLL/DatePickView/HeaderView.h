//
//  HeaderView.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *right;
@property (strong, nonatomic) IBOutlet UIView *tapView;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property(nonatomic,assign)NSInteger btnClickNum;

@property(nonatomic,copy)void(^leftBtnBlock)(NSInteger num,NSInteger year,NSInteger month,NSInteger day);

@property(nonatomic,copy)void(^moreBtnBlock)(id obj,BOOL isTop);
@end
