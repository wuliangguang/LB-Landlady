//
//  WaiterListModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaiterListModel : NSObject

@property (nonatomic, copy) NSString *business_id;

@property (nonatomic, copy) NSString *salesclerk_job;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *salesclerk_phone;

@property (nonatomic, copy) NSString *salesclerk_image;

@property (nonatomic, copy) NSString *salesclerk_name;

@property (nonatomic, assign) NSInteger salesclerk_id;

@property (nonatomic, assign) NSInteger is_flag;

@end
