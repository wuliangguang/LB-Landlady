//
//  OthersViewController.h
//  LB-Landlady
//
//  Created by d2space on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OthersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)block_void_t callHanderBlock;
@end
