//
//  ProductAddNewIntroductionCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"
typedef void (^CompeletInBlock)(NSString *string);
@interface ProductAddNewIntroductionCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet SZTextView *Intextview;
@property(nonatomic,copy)CompeletInBlock block;
@end
