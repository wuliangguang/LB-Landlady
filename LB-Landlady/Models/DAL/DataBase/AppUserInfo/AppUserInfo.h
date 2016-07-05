//
//  AppUserInfo.h
//  MeZoneB
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MyInfo.h"
#import "MyInfoDataModel.h"
#import "MerchantListItemModel.h"


@interface AppUserInfo : NSObject

/**
 *  是否已登录
 */
@property (nonatomic) BOOL haveLogIn;

/**
 *  我的基本信息
 */
@property (nonatomic) MyInfoDataModel *myInfo;

+ (instancetype)initAppUserInfo;

- (void)clearCache;

@end
