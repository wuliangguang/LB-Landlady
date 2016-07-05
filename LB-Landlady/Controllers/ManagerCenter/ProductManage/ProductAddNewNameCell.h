//
//  ProductAddNewNameCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^VlaueBlock) (NSString *str);
@interface ProductAddNewNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *productNameTextField;
@property(nonatomic,copy)VlaueBlock blcok;
@end