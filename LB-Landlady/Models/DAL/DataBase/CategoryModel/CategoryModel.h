//
//  CategoryModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/19/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic, getter=isCheck) BOOL check;

@end
