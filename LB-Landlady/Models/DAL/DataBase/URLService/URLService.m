//
//  URLService.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/11.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "URLService.h"

/**
 *  服务器地址：
 *  UAT：@"http://114.141.173.32:9001/BusinessControlApp"
 *  线上：@"http://114.141.173.25:9001/BusinessControlApp"
 *  线下：@"http://172.16.103.61:8080/BusinessControlApp"
 */

//static NSString *g_MainUrl     = @"http://114.141.173.32:9001/BusinessControlApp";//UAT

//static NSString *g_MainUrl     = @"http://114.141.173.25:9001/BusinessControlApp";//线上

/**
 *  新的测试路径
 公网文件系统：http://apiuat.xylbn.cn:9002/FileContrl/
 */
static NSString *g_MainUrl     =@"http://172.16.103.153:8080/lincombFront";
/**
 *  uat环境
 */

//static NSString *g_MainUrl     =@"http://apiuat.xylbn.cn:9003/BusinessControlApp";
/**
 *  生产
 */
//static NSString *g_MainUrl     =@"http://114.141.173.25:9012/BusinessControlApp";

static NSString *g_getCommitProductUrl = @"/template/product/release.html";

static NSString *g_AdvertismentUrl           = @"/advert/getAdvert.do";

static NSString *g_FeedBackUrl               = @"/feedBack/addFeedBack.do";

static NSString *g_SalesclerkListUrl         = @"/salesclerk/getSalesclerkListByBusiness.do";

static NSString *g_UpateSalesclerkUrl        = @"/salesclerk/updateSalesclerkById.do";

static NSString *g_DelSalesclerkUrl          = @"/salesclerk/delSalesclerkById.do";

static NSString *g_AddSalesclerkUrl          = @"/salesclerk/addSalesclerk.do";

static NSString *g_GetMoreServerMallUrl      = @"/serverMall/getMoreServerMall.do";

static NSString *g_MySelfServerMallUrl       = @"/serverMall/getMySelfServerMall.do";

static NSString *g_ServerMallListUrl         = @"/serverMall/getServerMallList.do";

static NSString *g_ServeMarket               = @"/template/serveMarket/list.html";

static NSString *g_AssociatorLevelListUrl    = @"/associator/getAssociatorLevelList.do";

static NSString *g_AssociatorUrl             = @"/associator/getAssociator.do";
/**
 *  用户登录接口
 */
//static NSString *g_LogInUrl                  = @"/user/userLogin.do";//
static NSString *g_LogInUrl                  = @"/user/userLogin.do";
/**
 *  获取用户信息接口(/user/getUserById)
 */
static NSString *g_MYInfo                    = @"/user/getUserById.do";
/**
 *  用户注册接口(/user/registerUser)
 */
//static NSString *g_Register                  = @"/user/registerUser.do";
static NSString *g_Register                  = @"/user/registerUser.do";

static NSString *g_SystemProtocol            = @"/template/system/protocol.html";
static NSString *g_SystemMakeUrl             = @"/template/system/installProtocol.html";
/**
 *  发送短信验证码(/user/registerMsgCode)
 */
//static NSString *g_VertifyCode               = @"/user/sendCode.do";
static NSString *g_VertifyCode               = @"/user/registerMsgCode";
/**
 *  修改用户信息接口(/user/updateUserById)
 */
static NSString *g_modifyUserInfo            = @"/user/updateUserById.do";

static NSString *g_changeVIPInfo             = @"/associator/updateAssociatorLevel.do";
/**
 *  忘记密码接口
 */
static NSString *g_forgetPsdForMyInfo        = @"/user/forgetPassword.do";

static NSString *g_OpenOrCloseLevel          = @"/associator/openOrCloseLevel.do";

static NSString *g_UpdateApplyStatus         = @"/associator/updateApplyStatus.do";

static NSString *g_MessageList               = @"/message/getMessageList.do";

static NSString *g_DelMessage                = @"/message/delMessage.do";

static NSString *g_UpdateMessage             = @"/message/updateMessage.do";
/**
 *  店铺详情接口
 */
static NSString *g_getBusinessInfo           = @"/business/getBusinessInfo.do";

static NSString *g_IntroduceUrl              = @"/template/introduce/index.html?type=";
/**
 *  修改默认店铺/business/updateDefaultBusinessByUserId
 */
static NSString *g_ChangeBusinessOnAppUrl    = @"/business/updateDefaultBusinessByUserId.do";

static NSString *g_AddProductSourceUrl       = @"/productSource/addProductSource.do";

static NSString *g_DelProductSourceUrl       = @"/productSource/delProductSource.do";

static NSString *g_ProductSourceListUrl      = @"/productSource/getProductSourceList.do";

static NSString *g_getProductSourcepReferenceUrl = @"/productSource/getProductSourcepReference.do";

static NSString *g_goodsSourceOffline        = @"/order/addProductSourceOrder.do";

static NSString *g_getProductSourceOrderList = @"/order/getProductSourceOrderListByBusinessId.do";

static NSString *g_getProductSourceOrder     = @"/productSource/getProductSourceOrderByBusiness.do";

static NSString *g_getSweep                  = @"/sweep/getSweep.do";

static NSString *g_getOrder                  = @"/order/getOrderById.do";

static NSString *g_orderQuery                = @"/sweep/orderQuery.do";

static NSString *g_getProductSource          = @"/productSource/getProductSourceById.do";

static NSString * g_getProductSourceDetailByBusinessProduct = @"/productSource/getProductSourceDetailByBusinessProductId.do";

static NSString *g_getProductSourceContactsUrl = @"/user/getProductSourceContacts.do";

static NSString *g_addProductSourceContactsUrl =@"/user/addProductSourceContacts.do";
/**
 *  行业分类接口(/industry/getIndustryList)
 */
static NSString *g_getIndustryListUrl = @"/industry/getIndustryList.do";
/**
 *  修改店铺接口/business/updateBusiness
 */
static NSString *g_updateBusinessLogoUrl = @"/business/updateBusiness.do";
/**
 *  修改店铺介绍接口（/business/updateBusinessIntroduce）
 */
static NSString *g_updateBusinessIntroduceUrl = @"/business/updateBusinessIntroduce.do";

static NSString *g_updateOrderStatuUrl = @"/order/updateOrderStatu.do";

static NSString *g_getProductPoolByBusinessUrl = @"/productPool/getProductPoolByBusiness.do";
/**
 *  修改登陆密码
 */
static NSString * g_rePasswordUrl = @"/user/rePassword.do";
/**
 *  店铺列表接口(/business/getBusinessList)
 */
static NSString * g_getBusinessByUserUrl = @"/business/getBusinessList.do";
/**
 *  新增店铺
 */
static NSString * g_addBusinessByBUrl = @"/business/addBusiness.do";

static NSString * g_addProductInfo = @"/product/addProductInfoByB.do";

static NSString * g_getProductList = @"/product/getProductListByBusiness.do";

static NSString * g_getAssociatorByBusinessAndLevel = @"/associator/getAssociatorByBusinessAndLevel.do";

static NSString * g_updateProductPoolStatus = @"/productPool/updateProductPoolStatus.do";

static NSString * g_getAssociatorByPhone = @"/associator/getAssociatorByPhone.do";

static NSString * g_delAssociator = @"/associator/delAssociator.do";

static NSString * g_updateAssociator = @"/associator/updateAssociator.do";

static NSString * g_getTenOrderList = @"/order/getTenOrderList.do";

static NSString * g_getBankListUrl = @"/bank/getBankList.do";

static NSString * g_addBankUrl = @"/bank/addBank.do";

static NSString * g_updateBankPasswordUrl = @"/bank/updateBankPassword.do";

static NSString * g_delBankUrl  = @"/bank/delBank.do";

static NSString * g_getAllBankUrl  = @"/bank/getAllBank.do";

static NSString * g_getIsTrueUrl = @"/bank/getIsTrue.do";

static NSString * g_getCountByBusinessUrl = @"/pay/queryTotalAmt.do";

static NSString * g_getCountByDayUrl = @"/pay/queryTotalAmt.do";

static NSString * g_getAmountByMonthUrl = @"/transaction/getAmountByMonth.do";

static NSString * g_getAmountByWeekUrl = @"/transaction/getAmountByWeek.do";

static NSString *g_getDetailOnline = @"/transaction/getDetailOnline.do";

static NSString * g_getDetailofflineUrl = @"/transaction/getDetailoffline.do";

static NSString * g_getOfflineCountByTwoHoursUrl = @"/transaction/getOfflineCountByTwoHours.do";

static NSString * g_getOnlineCountByTwoHoursUrl = @"/transaction/getOnlineCountByTwoHours.do";

static NSString * g_pictureForIncomeUrl = @"/template/financial/index.html";

//static NSString * g_getOfflineCountByBusinessUrl = @"/transaction/getOfflineCountByBusiness.do";///pay/queryPayOrderList.do
static NSString * g_getOfflineCountByBusinessUrl = @"/pay/queryPayOrderList.do";
static NSString * g_getOnlineCountByBusinessUrl = @"/transaction/getOnlineCountByBusiness.do";

static NSString * g_getOnlineLastWeekCountUrl = @"/transaction/getOnlineLastWeekCount.do";

static NSString * g_getOfflineLastWeekCountUrl = @"/transaction/getOfflineLastWeekCount.do";

static NSString * g_getOnlineCountByMonthUrl = @"/transaction/getOnlineCountByMonth.do";

static NSString * g_getOfflineCountByMonthUrl = @"/transaction/getOfflineCountByMonth.do";

static NSString * g_withdrawUrl = @"/transaction/withdraw.do";

static NSString * forgetPasswordUrl = @"/bank/forgetPassword.do";

static NSString * g_getWithDrawByUserIdUrl = @"/transaction/getWithDrawByUserId.do";

static NSString * g_getOrderListByBusinessIdDateStatuUrl = @"/order/getOrderListByBusinessIdDateStatu.do";//
/**
 *  获取省市列表接口
 */
static NSString * g_getProvinceListUrl = @"/province/getProvinceList.do";
static NSString * g_sendUpdatePasswordCodeUrl = @"/bank/sendUpdatePasswordCode.do";

static NSString * g_getBalanceUrl = @"/transaction/getBalance.do";

static NSString * g_updateBusinessPhoneUrl = @"/business/updateBusinessPhone.do";

static NSString * g_updateBusinessAddressUrl = @"/business/updateBusinessAddress.do";

static NSString * g_updateBusinessContactsUrl = @"/business/updateBusinessContacts.do";

static NSString * g_SweepPushCardUrl         = @"/sweep/pushCard.do";

//static NSString * g_PaymentSweepPayUrl       = @"/sweep/sweepPay.do";

static NSString * g_PaymentSweepPayUrl       = @"/pay/addSweepPay.do";
@implementation URLService

+(NSString *)updateBusinessContactsUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateBusinessContactsUrl];
}
+(NSString *)updateBusinessAddressUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateBusinessAddressUrl];
}
+(NSString *)updateBusinessPhoneUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateBusinessPhoneUrl];
}
+(NSString * )getBalanceUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getBalanceUrl];
}
+(NSString *)sendUpdatePasswordCodeUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_sendUpdatePasswordCodeUrl];
}
+(NSString *)getOrderListByBusinessIdDateStatuUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOrderListByBusinessIdDateStatuUrl];
}
+(NSString *)withdrawUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_withdrawUrl];
}

+(NSString *)getOfflineCountByMonthUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOfflineCountByMonthUrl];
}

+(NSString *)getOnlineCountByMonthUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOnlineCountByMonthUrl];
}
+(NSString *)getOfflineLastWeekCountUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOfflineLastWeekCountUrl];
}

+(NSString *)getOnlineLastWeekCountUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOnlineLastWeekCountUrl];
}
 +(NSString *)getOnlineCountByBusinessUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOnlineCountByBusinessUrl];
}
+(NSString *)updateAssociator
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateAssociator];
}


+(NSString *)delAssociator
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_delAssociator];
}


+(NSString *)getAssociatorByPhone
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getAssociatorByPhone];
}
+(NSString *)getMianServeUrl
{
    return g_MainUrl;
}

+(NSString *)getCommitProductUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getCommitProductUrl];
}

+(NSString *)getServiceMallUrl
{
    return @"http://192.168.1.66:7890/linktown_b/Template/serveMarket/list.html";
}

+(NSString *)getAdvertismentURL
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_AdvertismentUrl];
}

+(NSString *)getFeedBackUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_FeedBackUrl];
}
+(NSString *)getSalesclerkListByBusinessUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_SalesclerkListUrl];
}
+(NSString *)getUpateSalesclerkUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_UpateSalesclerkUrl];
}
+(NSString *)getDelSalesclerkUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_DelSalesclerkUrl];
}
+(NSString *)getAddSalesclerkUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_AddSalesclerkUrl];
}
+(NSString *)getMoreServerMallUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_GetMoreServerMallUrl];
}
+(NSString *)getMySelfServerMallUrl
{
   return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_MySelfServerMallUrl];
}
+(NSString *)getServerMallListUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_ServerMallListUrl];
}
+(NSString *)getServeMarket {
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_ServeMarket];
}
+(NSString *)getAssociatorLevelListUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_AssociatorLevelListUrl];
}
+(NSString *)getAssociatorUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_AssociatorUrl];
}

+ (NSString *)logIn
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_LogInUrl];
}

+ (NSString *)myInfo
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_MYInfo];
}

+ (NSString *)regist
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_Register];
}
+ (NSString *)getSystemProtocolUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_SystemProtocol];
}

+ (NSString *)getSystemMakeUrl{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_SystemMakeUrl];
}
+(NSString *)getVertifyCode
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_VertifyCode];
}
+(NSString *)modifyUserInfo
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_modifyUserInfo];
}

+(NSString *)changeVIPInfo{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_changeVIPInfo];
}

+(NSString *)forgetPsdForMyInfo
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_forgetPsdForMyInfo];
}
+(NSString *)getOpenOrCloseLevelUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_OpenOrCloseLevel];
}
+(NSString *)getUpdateApplyStatusUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_UpdateApplyStatus];
}
+(NSString *)getMessageListUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_MessageList];
}
+(NSString *)getDelMessageUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_DelMessage];
}
+(NSString *)updateMessageUrl {
    return [NSString stringWithFormat:@"%@/%@",g_MainUrl,g_UpdateMessage];
}
+ (NSString *)getBusinessInfoUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getBusinessInfo];
}
+(NSString *)getIntroduceUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_IntroduceUrl];
}
+(NSString *)getChangeBusinessOnAppUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_ChangeBusinessOnAppUrl];
}
+(NSString *)getAddProductSourceUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_AddProductSourceUrl];
}
+(NSString *)getDelProductSourceUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_DelProductSourceUrl];
}
+(NSString *)getProductSourceListUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_ProductSourceListUrl];
}
+(NSString *)getProductSourcepReferenceUrl {
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProductSourcepReferenceUrl];
}
+ (NSString *)addProductSourceOrderUrl {
    return [NSString stringWithFormat:@"%@%@", g_MainUrl, g_goodsSourceOffline];
}
+(NSString * )orderProductionSourceList
{
    return [NSString stringWithFormat:@"%@%@", g_MainUrl, g_getProductSourceOrder];
}
+(NSString *)QScanCode
{
    return [NSString stringWithFormat:@"%@%@", g_MainUrl, g_getSweep];
}
+(NSString *)getOrder
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOrder];
}
+(NSString *)orderQuery
{
    return [NSString stringWithFormat:@"%@%@", g_MainUrl, g_orderQuery];
}
+(NSString *)getProductSource
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProductSource];
}
+(NSString *)getProductSourceDetailByBusinessProduct
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProductSourceDetailByBusinessProduct];
}
+(NSString *)getProductSourceContactsUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProductSourceContactsUrl];
}
+(NSString *)addProductSourceContactsUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_addProductSourceContactsUrl];
}
+ (NSString *)getProinveListUrl{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProvinceListUrl];
}
+ (NSString *)getIndustryListUrl {
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getIndustryListUrl];
}
+ (NSString *)updateBusinessLogoUrl {
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateBusinessLogoUrl];
}
+ (NSString *)updateBusinessIntroduceUrl {
    return [NSString stringWithFormat:@"%@%@", g_MainUrl, g_updateBusinessIntroduceUrl];
}
+(NSString *)updateOrderStatuUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateOrderStatuUrl];
}
+(NSString *)getProductPoolByBusinessUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProductPoolByBusinessUrl];
}
+(NSString *)rePasswordUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_rePasswordUrl];
}
+(NSString *)getBusinessByUserUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getBusinessByUserUrl];
}
+(NSString *)addBusinessByBUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_addBusinessByBUrl];
}
+(NSString * )addProductInfo
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_addProductInfo];
}
+(NSString *)getProductList
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getProductList];
}
+(NSString *)getAssociatorByBusinessAndLevel
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getAssociatorByBusinessAndLevel];
}
+(NSString *)updateProductPoolStatus
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateProductPoolStatus];
}
+(NSString *)getTenOrderList
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getTenOrderList];
}
+(NSString *)getBankListUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getBankListUrl];
}
+(NSString *)addBankUrl{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_addBankUrl];
}
+(NSString *)updateBankPasswordUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_updateBankPasswordUrl];
}
+(NSString *)delBankUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_delBankUrl];
}
+(NSString *)getAllBankUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getAllBankUrl];
}
+(NSString *)getIsTrueUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getIsTrueUrl];
}
+(NSString *)getCountByBusiness
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getCountByBusinessUrl];
}
+(NSString *)getCountByDay
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getCountByDayUrl];
}
+(NSString *)getAmountByMonthUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getAmountByMonthUrl];
}

+(NSString *)getAmountByWeekUrl;
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getAmountByWeekUrl];
}

+(NSString *)getDetailOnlineUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getDetailOnline];
}
+(NSString *)getDetailofflineUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getDetailofflineUrl];
}
+(NSString *)getOfflineCountByTwoHoursUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOfflineCountByTwoHoursUrl];
}
+(NSString *)getOnlineCountByTwoHoursUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOnlineCountByTwoHoursUrl];
}
+(NSString *)pictureForIncomeUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_pictureForIncomeUrl];
}
+(NSString *)getOfflineCountByBusinessUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getOfflineCountByBusinessUrl];
}

+(NSString *)forgetPasswordUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,forgetPasswordUrl];
}

+(NSString * )getWithDrawByUserIdUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_getWithDrawByUserIdUrl];
}

+(NSString *)getSweepPushCardUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_SweepPushCardUrl];
}

+ (NSString *)getPaymentSweepPayUrl
{
    return [NSString stringWithFormat:@"%@%@",g_MainUrl,g_PaymentSweepPayUrl];
}
@end
