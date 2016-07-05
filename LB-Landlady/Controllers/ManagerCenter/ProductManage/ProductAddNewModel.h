//
//  ProductAddNewModel.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/21.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductAddNewModel : NSObject
@property(nonatomic,copy)NSString *nameString;
@property(nonatomic,copy)NSString *inString;
@property(nonatomic,copy)NSString *priceString;
@property(nonatomic,strong)UIImage *productImage;
@property(nonatomic,copy)NSString *numberString;
@property(nonatomic,copy)NSString *unitString;
@end
