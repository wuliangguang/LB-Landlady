//
//  MyInfoDataModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/26/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyInfo.h"
#import "MyBusinessInfoModel.h"
#import "MerchantListItemModel.h"

@interface MyInfoDataModel : NSObject

/**
 *  用户信息
 */
@property (nonatomic) MyInfo *userModel;

/**
 *  商铺信息
 */
@property (nonatomic) MyBusinessInfoModel *businessModel;

@end
