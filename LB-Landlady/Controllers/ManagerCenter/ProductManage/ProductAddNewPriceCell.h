//
//  ProductAddNewPriceCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompeletPriceBlock)(NSString *string);
@interface ProductAddNewPriceCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *priceTextfield;
@property(nonatomic,copy)CompeletPriceBlock block;
@end
