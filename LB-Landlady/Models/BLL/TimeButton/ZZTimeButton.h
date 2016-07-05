//
//  ZZTimeButton.h
//  ZZTimeButton
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  封装倒计时button
 */
@interface ZZTimeButton : UIButton

@property (nonatomic) NSInteger timeInterval; // 以秒为单位，默认为60

- (void)invalidTimer;

/**
 *  开始倒计时
 */
- (void)startBackTime;

/**
 *  显示停止，默认倒计时结束后自动停止
 */
- (void)stop;

@end
