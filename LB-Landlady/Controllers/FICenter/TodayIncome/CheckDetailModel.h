//
//  CheckDetailModel.h
//  MeZoneB_Bate
//
//  Created by 喻晓彬 on 15/10/28.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckDetailModel : NSObject
@property (nonatomic,strong) NSNumber *amount;  // 金额
@property (nonatomic,strong) NSString *banknum; // 银行卡号
@property (nonatomic,strong) NSString *createTime;  //取款时间
@property(nonatomic,strong)NSString * reason;
@property (nonatomic,strong) NSString *bank_w_id; // ID
@property(nonatomic,assign)NSInteger status;

@end
