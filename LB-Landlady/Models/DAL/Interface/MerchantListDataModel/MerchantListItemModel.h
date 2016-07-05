//
//  MerchantListItemModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/27/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantListItemModel : NSObject

@property (nonatomic, copy) NSString  *phone;
@property (nonatomic      ) NSInteger industryId;
@property (nonatomic, copy) NSString  *businessName;
@property (nonatomic, copy) NSString  *address;
@property (nonatomic, copy) NSString  *businessId;
@property (nonatomic, copy) NSString  *contactName;
@property (nonatomic, copy) NSString  *userId;
@property (nonatomic, copy) NSString  *longitude;
@property (nonatomic, copy) NSString  *latitude;
@property (nonatomic, copy) NSString  *license;
@property (nonatomic, copy) NSString  *provinceId;
@property (nonatomic, copy) NSString  *qrcodeUrl;
@property (nonatomic) BOOL check;

@end
