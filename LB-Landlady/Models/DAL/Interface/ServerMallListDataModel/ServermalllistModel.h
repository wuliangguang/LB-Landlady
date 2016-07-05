//
//  ServermalllistModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateTimeModel.h"

@interface ServermalllistModel : NSObject

@property (nonatomic, copy  ) NSString  *icon;
@property (nonatomic, copy  ) NSString  *detail;

@property (nonatomic, assign) NSInteger mall_id;
@property (nonatomic, assign) NSInteger download_count;
@property (nonatomic, copy  ) NSString  *url;
@property (nonatomic, assign) NSInteger is_commoned;
@property (nonatomic, copy  ) NSString  *mall_name;
@property (nonatomic, copy  ) NSString  *user_id;
@end
