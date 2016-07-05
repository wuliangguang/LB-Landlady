//
//  OrderTheDetailCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void (^Block_chuan_T)(NSString *string);
@interface OrderTheDetailCell : UITableViewCell
@property(nonatomic)NSString *string;
@property(nonatomic,copy)block_id_t block;
@property (weak, nonatomic) IBOutlet UIButton *orderTheDetailButton;
@property (weak, nonatomic) IBOutlet UIButton *incomeTheDetailButton;
- (IBAction)orderDetailButtonClock:(id)sender;
- (IBAction)incomeDetailButtonClock:(id)sender;

@end
