//
//  DirectivePageViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  功能引导控制器
 */
@interface DirectivePageViewController : UIViewController

/**
 *  功能引导页保存在本地，固定，此属性留作接口，以备从服务器取出图片
 */
@property (nonatomic) NSArray *images;

@property (nonatomic, copy) void (^endCallback)();

@end
