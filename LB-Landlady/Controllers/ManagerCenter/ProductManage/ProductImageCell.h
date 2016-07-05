//
//  ProductImageCell.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompeletBlcok)(UIButton *button);
@interface ProductImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *productImageButton;
- (IBAction)productImageButtonClock:(id)sender;
@property(nonatomic,copy)CompeletBlcok block;
@end
