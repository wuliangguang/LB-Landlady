//
//  DateView.h
//  demo
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonView.h"

#import "StartEndView.h"
#import "HeaderView.h"

typedef enum
{
    ViewStyle_Day,
    ViewStyle_HIDDEN,
    ViewStyle_TwoBtn,
}ViewStyle;

@interface DateView : UIView
@property(nonatomic,assign)ViewStyle style;
@property(nonatomic,strong)ButtonView * buttonView;
@property(nonatomic,strong)HeaderView * headerView;
@property(nonatomic,copy)NSString * dateStr;
@property(nonatomic,copy)NSString * yearAndMonth;/**<点击左箭头返回的年月*/
@property(nonatomic)NSInteger selectIndex;/**<点击的button的index*/

@property(nonatomic,strong) StartEndView * startAndEndTimeView ;
@property(nonatomic,copy)void (^maskViewAnimation) (id obj,BOOL isTop);


@property(nonatomic,copy)void (^BtnBlock)(id obj,TIMETYPE type);
@property(nonatomic,copy)void(^dayBtnClick)(NSString * data);

@end
