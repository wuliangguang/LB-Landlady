//
//  DatePickerView.h
//  demo
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define currentMonth [currentMonthString integerValue]

@interface DatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,copy)void(^CancleAndDoneBlock)(id obj,NSString * dateStr,NSString * date);
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end
