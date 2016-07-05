//
//  ZZContainerConfiguration.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/20/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZContainerConfiguration : NSObject

@property (nonatomic) NSArray *viewControllers;
@property (nonatomic) CGFloat contentHeight;
@property (nonatomic, copy) void (^didChangeControllerHandler)(UIViewController *controller);
@end
