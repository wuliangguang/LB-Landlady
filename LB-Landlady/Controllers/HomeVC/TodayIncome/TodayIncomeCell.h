//
//  TodayIncomeCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayIncomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
- (void)updateWithString:(NSString *)str;
@end
