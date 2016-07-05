//
//  MySourcePublicTimeChooseView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/19/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySourcePublicTimeChooseView : UIView

@property (nonatomic, copy) void (^startTimeCallback)(NSDate *date);
@property (nonatomic, copy) void (^endTimeCallback)(NSDate *date);

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@end
