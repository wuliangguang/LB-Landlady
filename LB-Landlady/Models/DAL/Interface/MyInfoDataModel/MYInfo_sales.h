//
//  MYInfo_sales.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/26.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYInfo_sales : NSObject

@property (nonatomic, copy) NSString *userId;//
@property (nonatomic, copy) NSString *lastLogin;
@property (nonatomic, copy) NSString *username;//
@property (nonatomic, copy) NSString *mobile;//
@property (nonatomic, copy) NSString *email;//
@property (nonatomic, copy) NSString *urgent;//
@property (nonatomic, copy) NSString *urgentPhone;//
@property (nonatomic, copy) NSString *userImage;//
@property (nonatomic, copy) NSString *password;//
@property (nonatomic, copy) NSString *userImageThumb;
@property (nonatomic) BOOL is_flag;//
@end
