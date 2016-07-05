//
//  MyBusinessInfoModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/25/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessImage.h"
#import "MerchantListItemModel.h"

@interface MyBusinessInfoModel : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *businessName;
@property (nonatomic, copy) NSString *QRcode_url;
@property (nonatomic, copy) NSString *industryId;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic      ) double   longitude;
@property (nonatomic      ) double   latitude;
@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *license;
@property (nonatomic, copy) NSString *businessImage;
@property (nonatomic      ) NSArray  *businessImgURL;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *logoUrl;
@property (nonatomic ,copy) NSString *header_url;//门头照
@property (nonatomic ,copy) NSString *health_url;//卫生许可证
@property (nonatomic ,copy) NSString *province_id;//所属省份

/**
 *  登录成功后服务器返回的商铺信息和商铺列表信息字段不匹配
 */
- (MerchantListItemModel *)convertToMerchantListItemModel;

@end
