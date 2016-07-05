//
//  GoodSourceDetailBusinessInfo.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodSourceDetailBusinessData : NSObject

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *businessName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *license;
@property (nonatomic) NSArray *businessimgURL;
@end

@interface GoodSourceDetailBusinessInfoModel : NSObject

@property (nonatomic) GoodSourceDetailBusinessData *data;
@end
