//
//  ZZDatePickerAttachView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/19/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZDatePickerAttachView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) void (^callbackHandler)(NSDate *date);
@property (nonatomic) NSDate *currentDate;
@end