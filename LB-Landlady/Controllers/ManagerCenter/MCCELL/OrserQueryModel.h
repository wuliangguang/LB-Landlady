//
//  OrserQueryModel.h
//  ZBL
//
//  Created by 张伯林 on 16/3/31.
//  Copyright © 2016年 张伯林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrserQueryModel : NSObject
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *businessName;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic)int payAmt;
@property(nonatomic,strong)NSString *payTime;
@property(nonatomic,strong)NSString *payType;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *status;

@end
