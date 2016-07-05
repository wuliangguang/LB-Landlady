//
//  MySourcePublicTimeOptionView.h
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MySourcePublicTimeOptionType) {
    MySourcePublicTimeOptionTypeWeek     = 0, // 当周有效
    MySourcePublicTimeOptionTypeMonth    = 1, // 当月有效
    MySourcePublicTimeOptionTypeYear     = 2, // 当年有效
    MySourcePublicTimeOptionTypeLongTime = 3, // 长期有效
    MySourcePublicTimeOptionTypeCustom   = 4  // 自定义时间
};

@interface MySourcePublicTimeOptionView : UIView
@property (nonatomic) MySourcePublicTimeOptionType type;

- (void)showWithType:(MySourcePublicTimeOptionType)type completionHandler:(void (^)(MySourcePublicTimeOptionType type, NSString *typeInfo))completionHandler;

@end
