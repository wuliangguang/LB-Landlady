//
//  BindShopManager.h
//  LB-Landlady
//
//  Created by 刘威振 on 3/3/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MerchantInfoStatusUnknown,
    MerchantInfoStatusSuccess,
    MerchantInfoStatusFail,
} MerchantInfoStatus;

@protocol MerchantInfoManagerProtocol <NSObject>

- (void)handleMerchantInfo:(MerchantInfoStatus)status;
@end

/**
 *  店铺信息管理器
 */
@interface MerchantInfoManager : NSObject

@property (nonatomic, copy) void (^merchantInfoHandler)(MerchantInfoStatus status);

+ (void)merchantInfoWithInfo:(NSDictionary *)info completionHandler:(void (^)(MerchantInfoStatus status))handler;

+ (void)merchantInfoWithInfo:(NSDictionary *)info controller:(UIViewController *)controller completionHandler:(void (^)(MerchantInfoStatus status))handler;

@end
