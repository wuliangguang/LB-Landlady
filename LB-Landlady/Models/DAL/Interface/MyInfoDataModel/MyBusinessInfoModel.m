//
//  MyBusinessInfoModel.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/25/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyBusinessInfoModel.h"

@implementation MyBusinessInfoModel

- (MerchantListItemModel *)convertToMerchantListItemModel {
    MerchantListItemModel *itemModel = [[MerchantListItemModel alloc] init];
    itemModel.phone                  = self.mobile;
    // itemModel.industry_id         = ??
    // itemModel.id                  = ??
    itemModel.businessName          = self.businessName;
    itemModel.address                = self.address;
    itemModel.businessId            = self.businessId;
    itemModel.contactName           = self.contactName;
    itemModel.userId                = self.userId;
    itemModel.longitude              = [NSString stringWithFormat:@"%lf", self.longitude];
    itemModel.latitude               = [NSString stringWithFormat:@"%lf", self.latitude];
    itemModel.license                = self.license;
    return itemModel;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"businessImgURL" : [BusinessImage class]};
}

@end
