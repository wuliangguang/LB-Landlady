//
//  HomeServiceMallHeadView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/25/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  由于时间关系，此处简单封装
 */
@interface HomeServiceMallHeadView : UIView

@property (nonatomic) NSArray *items;
@property (nonatomic, copy) void (^callbackHandler)(UIButton *button, NSInteger index);

@end
