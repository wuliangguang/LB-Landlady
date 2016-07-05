//
//  ProvinceView.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/29.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^compeleteProinvceBlcok)(NSString *provinceId, NSString *province);
typedef void (^comAddTouchBlcok)();
@interface ProvinceView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)compeleteProinvceBlcok proinvceBlcok;
@property(nonatomic,copy)comAddTouchBlcok addTouchBlcok;
- (instancetype)initWithFrame:(CGRect)frame;

@end
