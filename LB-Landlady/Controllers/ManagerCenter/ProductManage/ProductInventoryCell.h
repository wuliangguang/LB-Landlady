//
//  ProductInventoryCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompeletInventoryBlock)(NSString *nuberString,NSString *unitString);
@interface ProductInventoryCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *UnitTextField;
@property(nonatomic,copy)CompeletInventoryBlock block;
@end
