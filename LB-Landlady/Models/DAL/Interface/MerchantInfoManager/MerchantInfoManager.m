//
//  BindShopManager.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/3/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MerchantInfoManager.h"
#import "RootViewController.h"
#import "CommonModel.h"
#import "MBProgressHUD+ZZConvenience.h"

@implementation MerchantInfoManager

static MerchantInfoManager *_merchantInfoManager = nil;

+ (instancetype)sharedMerchantInfoManager {
    if (_merchantInfoManager == nil) {
        _merchantInfoManager = [[MerchantInfoManager alloc] init];
    }
    return _merchantInfoManager;
}

/**
 *  B端切换店铺
 *  @param  userId 		string
 *  @param  businessId	string	店铺名称
 *  @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		}
 * 	}
 */
+ (void)merchantInfoWithInfo:(NSDictionary *)info completionHandler:(void (^)(MerchantInfoStatus status))handler {
    [self merchantInfoWithInfo:info controller:[[[UIApplication sharedApplication] keyWindow] rootViewController] completionHandler:handler];
}

+ (void)merchantInfoWithInfo:(NSDictionary *)info controller:(UIViewController *)controller completionHandler:(void (^)(MerchantInfoStatus status))handler {
    MerchantInfoManager *merchantInfoManager = [MerchantInfoManager sharedMerchantInfoManager];
    merchantInfoManager.merchantInfoHandler  = handler;
    [S_R LB_PostWithURLString:[URLService getBusinessInfoUrl] WithParams:info WithSuccess:^(id responseObject, id responseString) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", responseString);
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MyBusinessInfoModel class]];
            if (commonModel.code == SUCCESS_CODE) {
                if (!commonModel.data) {
                    [MBProgressHUD showFailToast:@"切换店铺失败" inView:[[UIApplication sharedApplication] keyWindow] completionHandler:nil];
                    return ;
                }
                App_User_Info.myInfo.businessModel        = commonModel.data;
                App_User_Info.myInfo.userModel.defaultBusiness = App_User_Info.myInfo.businessModel.businessId;
                if (merchantInfoManager.merchantInfoHandler) {
                    merchantInfoManager.merchantInfoHandler(MerchantInfoStatusSuccess);
                }
                [merchantInfoManager refreshViewControllers:MerchantInfoStatusSuccess];
            } else {
                if (merchantInfoManager.merchantInfoHandler) {
                    merchantInfoManager.merchantInfoHandler(MerchantInfoStatusFail);
                }
                [merchantInfoManager refreshViewControllers:MerchantInfoStatusFail];
            }
        });
    } failure:^(NSError *error) {
        if (merchantInfoManager.merchantInfoHandler) {
            merchantInfoManager.merchantInfoHandler(MerchantInfoStatusFail);
        }
    } WithController:controller];
}

- (void)refreshViewControllers:(MerchantInfoStatus)status {
    RootViewController *rootController = (RootViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    for (UINavigationController *nivController in rootController.viewControllers) {
        UIViewController *controller = nivController.viewControllers[0];
        if ([controller conformsToProtocol:@protocol(MerchantInfoManagerProtocol)] && [controller respondsToSelector:@selector(handleMerchantInfo:)]) {
            UIViewController<MerchantInfoManagerProtocol> *conformController = (UIViewController<MerchantInfoManagerProtocol> *)controller;
            if (conformController.isViewLoaded) {
                [conformController handleMerchantInfo:status];
            }
        }
    }
    
    _merchantInfoManager = nil; // 优化内存，完成任务后结束自己
}

@end
