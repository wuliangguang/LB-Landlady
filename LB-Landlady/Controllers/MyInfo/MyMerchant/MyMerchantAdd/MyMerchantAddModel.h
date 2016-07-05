//
//  MyMerchantAddModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/26/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMerchantAddModel : NSObject

/**
 *  店铺名称
 */
@property (nonatomic, copy) NSString *businessName;

/**
 *  地址
 */
@property (nonatomic, copy) NSString *address;

/**
 *   行业类别Id
 */
@property (nonatomic, copy) NSString *industryId;

/**
 *  用户Id
 */
@property (nonatomic, copy) NSString *userId;

/**
 *  营业执照
 */
@property (nonatomic, copy) NSString *license;

/**
 *  联系人
 */
@property (nonatomic, copy) NSString *contactName;

/**
 *  联系电话
 */
@property (nonatomic, copy) NSString *phone;

/**
 *  纬度
 */
@property (nonatomic, copy) NSString *latitude;

/**
 *  经度
 */
@property (nonatomic, copy) NSString *longitude;

/**
 *  开始营业时间 (yyyy-hh-dd) 不传
 */
@property (nonatomic, copy) NSString *openTime;

/**
 *  关闭营业时间 (yyyy-hh-dd) 不传
 */
@property (nonatomic, copy) NSString *closeTime;
/**
 *  店铺所属省市名
 */
@property (nonatomic, copy) NSString *province;
/**
 *  店铺所属省市ID
 */
@property (nonatomic, copy) NSString *provinceId;
@end