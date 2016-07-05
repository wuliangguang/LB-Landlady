//
//  HomePopContentView.h
//  LB-Landlady
//
//  Created by 刘威振 on 3/9/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePopContentView : UIView

+ (instancetype)homePopContentView;

@property (nonatomic, copy) block_void_t orderListHandler;
@property (nonatomic, copy) block_void_t orderGenerateHandler;
@end
