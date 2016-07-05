//
//  URLService.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/11.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLService : NSObject
/**
 *  获取省市列表接口
 *
 *  @return <#return value description#>
 */
+(NSString *)getProinveListUrl;


+(NSString * )getMianServeUrl;
/**
 * 扫一扫 (根据扫出来的编号获取相应的数据)
	* @author kai.li
	*	@param  	code		string			扫一扫编号
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		   Object	obj		编号对应的某个对象
	* 	}
 *
 */
+(NSString *)QScanCode;
#pragma mark ************************登录模块*************************
/**
 *  获取验证码
 *   * 	@param	phone		string		电话
 * @param      type   string 类型    1:注册 2:忘记密码
 
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
 *
 */
+(NSString * )getVertifyCode; //OK

/**
	* @see 用户注册
	* @author kai.li
 * 	@param	phone		string		电话号码
 * 	@param	password	string	 	密码
 * 	@param	repassword	string	 	重复密码
 * 	@param	QRCode		string	 	验证码
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
	*/
+ (NSString *)regist; // OK PT

/**
	* @see 用户登录
	* @author kai.li
 * 	@param	userId		string		用户名
 * 	@param	password	string	 	密码
 
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		userId		int			用户ID
 * 		lastLogin	string		上次登录时间
 * 		userName	string		用户名
 * 		mobile		string		电话
 * 		address		string		地址
 * 		img			string		图片
 * 		email		string		邮箱
 * 		urgent		string		紧急联系人
 * 		urgent_phone	string	紧急联系电话
	* 	}
	*/
+ (NSString *)logIn; //OK PT

/**
 *  注册，老板娘协议 web页面
 */
+ (NSString *)getSystemProtocolUrl; // OK

/**
 *  注册，老板娘协议 web页面
 */
+ (NSString *)getSystemMakeUrl;
#pragma mark ************************个人中心－个人资料*************************

/**
 * @see 修改密码
	* @author kai.li
 * 	@param	userId		string		用户ID
 * 	@param	password	string	 	密码
 *  @param  newPassword string      新密码
 * 	@param	repassword	string	 	重复密码
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
 */
+(NSString *)rePasswordUrl;

/**
 *   * 	@param	userId		string		电话号码
 * 	@param	password	string	 	密码
 * 	@param	QRCode		string	 	验证码
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
 *
 */
+(NSString * )forgetPsdForMyInfo; // OK

/*
 *修改用户信息
	* @author kai.li
 * 	@param	userId		string			用户ID
 * 	@param	userName	string		用户名
 * 	@param	image		string		图片
 * 	@param	password	string		密码
 * 	@param	mobile		string		电话
 * 	@param	urgent		string		紧急联系人
 * 	@param	urgentPhone	string	紧急联系电话
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
 */

+(NSString *)modifyUserInfo; // OK

/**
	* @see 获取用户详细
	* @author kai.li
	* @param  	userId		string			用户ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		userId		int			用户ID
 * 		lastLogin	string		上次登录时间
 * 		userName	string		用户名
 * 		mobile		string		电话
 * 		address		string		地址
 * 		img			string		图片
 * 		email		string		邮箱
 * 		urgent		string		紧急联系人
 * 		urgent_phone	string	紧急联系电话
	* 	}
	*/
+ (NSString *)myInfo; // OK PT 进入我的

#pragma mark ************************个人中心－其它****************************
/**
 *  新增意见反馈
 * 	@param	userId		string		用户ID
 * 	@param	contant		string		内容
 * 	@param	title		string		标题
 *  @return 
    data:{
 *          code:  true:code=200,false:code!=200
 *          dataCode: number	返回非错误逻辑性异常code
 *          resultMsg: string 	返回信息
 *          totalCount : int	返回总条数
 *          data:{}
* 	}
 */
+(NSString *)getFeedBackUrl; // OK
#pragma mark ************************个人中心－消息****************************
/**
	* 显示门店信息
	* @param	businessId		string  门店Id
	* @param    currentPageNum	int			当前页面数
	* @param	pageSize		int			获取数据数
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 		messageList[
 * 		{
 * 			messageId	int
 * 			messageType	int
 * 			messageTitle	string
 * 			messageContent	string
 * 			createTime		string
 * 			businessId		string
 * 			isRead			int
 * 		},{...}
 * 	]
 * }
	*	}
	*/
+(NSString *)getMessageListUrl;


/**
	* 删除信息
	* @param messageId string  消息Id
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * }
	*	}
	*/
+(NSString *)getDelMessageUrl;

/**
	* @see 修改信息状态
	* @author kai.li
	* @param	messageId		string  消息ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	resultMsg: string 	返回信息
 * 	data:{
 * }
	*	}
	*/
+(NSString *)updateMessageUrl;

#pragma mark ************************个人中心－我的商铺*************************

/**
 *  修改店铺联系人
 * @param businessId
 *            string 店铺id
 * @param contactName
 *            String 联系人
 *
 */
+(NSString *)updateBusinessContactsUrl;
/**
 * @see 修改店铺联系电话
 * @param businessId
 *            string 店铺id
 * @param phone
 *            String 联系电话
 * @return data:{ code: true:code=200,false:code!=200 dataCode: number
 *         返回非错误逻辑性异常code resultMsg: string 返回信息 totalCount : int 返回总条数
 *         data:{
 *
 *         } }
 */
+(NSString *)updateBusinessPhoneUrl;
/**
 * @see 修改店铺地址
 * @param businessId
 *            string 店铺id
 * @param address
 *            String 地址
 * @param latitude
 *            String 纬度
 * @param longitude
 *            String 经度
 * @return data:{ code: true:code=200,false:code!=200 dataCode: number
 *         返回非错误逻辑性异常code resultMsg: string 返回信息 totalCount : int 返回总条数
 *         data:{
 *
 *         } }
 */
+(NSString *)updateBusinessAddressUrl;

/**
 *  获取我的商铺信息
 *  @param businessId 商户id号
 */
+ (NSString *)getBusinessInfoUrl;

/**
 * @see 新增店铺B端
 * @author kai.li
 *	@param	businessName	string		店铺名称
 *	@param	address 		String		地址
 *	@param	industryId		string	    行业类别Id
 *	@param	userId			string		用户Id
 *	@param	license		    string	    营业执照
 *	@param	contactName 	string		联系人
 *	@param	phone			string		联系电话
 *	@param	openTime		string		开始营业时间 (yyyy-hh-dd)
 *	@param	closeTime		string		关闭营业时间 (yyyy-hh-dd)
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 			businessId		string	商铺Id
 * 	}
 * 	}
 */
+(NSString *)addBusinessByBUrl; // PT

/**
 * @see 取得用户下的店铺 获取店铺列表
 * @author kai.li
 *				@param  userId			string	用户Id
 *				@param  currentPageNum	int			当前页面数
 *				@param	pageSize		int			获取数据数
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 	  business[{
 *	  	businessId	String  门店Id,
 *	  	businessName 	String 	门店名称,
 *	  	address 		String	地址,
 *	  	industryId	int		类别Id,
 *	  	stuats 			int		 状态,
 *	  	industryMajors [{"主营类型Id","主营类型名"}]   主营类型	,
 *	  	license			string   营业许可证,
 *	  	phone			string	  联系电话,
 *	  	introduce		string	  介绍,
 *	  	details			string   详细,
 *	  	logo			string	 LOGO,
 *	  	area{"areaId","areaName"}        商圈,
 *	  	opentingTime	string			开始营业时间(yyyy-hh-dd),
 *	  	closingTime	string			关闭营业时间(yyyy-hh-dd),
 *	  	isPause		int				是否停止营业 0：false,1:true;,,
 *	  	latitude		float			经度,
 *	  	longitude		float			纬度,
 *		businessImg		[{image},{....}]  门店图片
 *		},{...}
 *	  ]
 *  	 }
 * 	}
 */
+(NSString *)getBusinessByUserUrl;

/**
 * @see 新增货源联系人
	* @author kai.li
 * 	@param	userId		string		用户名
 * 	@param	img			string	 	图片
 * 	@param	phone		string	 	联系电话
 * 	@param	name		string	 	联系人名称
 * 	@param	sourceName	string	 	货源名称
 * 	@param	sourceDetail	string	 货源内容
	*   @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
 */

+(NSString *)addProductSourceContactsUrl;

/**
 *  B端切换店铺
 *  @param  userId 		string
 *  @param  businessId	string	店铺名称
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		}
 * 	}
 */
+ (NSString *)getChangeBusinessOnAppUrl;
/**
 *  行业分类
 */
+ (NSString *)getIndustryListUrl; // PT

/**
 * @see 修改店铺LOGO
 * @param businessId
 *            string 店铺id
 * @param logo
 *            String logo
 * @return data:{ code: true:code=200,false:code!=200 dataCode: number
 *         返回非错误逻辑性异常code resultMsg: string 返回信息 totalCount : int 返回总条数
 *         data:{
 *
 *         } }
 */
+ (NSString *)updateBusinessLogoUrl;

/**
 * @see 修改店铺介绍
 * @param businessId
 *            string 店铺id
 * @param introduce
 *            String 简介
 * @param detail
 *            String 详情
 * @param image
 *            String 图片
 * @return data:{ code: true:code=200,false:code!=200 dataCode: number
 *         返回非错误逻辑性异常code resultMsg: string 返回信息 totalCount : int 返回总条数
 *         data:{
 *
 *         }
 */
+ (NSString *)updateBusinessIntroduceUrl;

#pragma mark ************************个人中心－我的货源*************************

/**
 * @see 显示货源联系人
	* @author kai.li
 * 	@param	userId		string		用户名
 * 	@param	img			string	 	图片
 * 	@param	phone		string	 	联系电话
 * 	@param	name		string	 	联系人名称
 * 	@param	sourceName	string	 	货源名称
 * 	@param	sourceDetail	string	 货源内容
	*   @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 			userList[
 * 			{
 * 			   	userId		string		用户名
 * 				img			string	 	图片
 * 				phone		string	 	联系电话
 * 				name		string	 	联系人名称
 * 				sourceName	string	 	货源名称
 * 				sourceDetail	string	 货源内容
 *
 * 			},{...}
 * 		]
	* 	}
 */
+(NSString *)getProductSourceContactsUrl;

/**
 * @see 获取货源下单的卖家详细以及货源订单详细
 * @author kai.li
 *  @param	 businessId	string	行业类别           行业类别  多个用英文“,”逗号隔开
 *  @param   productSourceId	String			当前页面数
 * @return
 * 	data:{
 * 	code:  true:code=0,false:code!=200
 * 		productSource:{
 * 						productSourceId  string   货源ID
 * 						image 			 string	     图片
 * 						productSourceTitle  string 标题
 * 						validEndDate     string   失效日期
 *                       vailidStartDate    string   开始日期
 *                       unit               string   单位
 *                       price				string	金额
 *                       businessId			string  商铺ID
 *                       detail				string	详细
 * 			}
 * 	  business:{
 * 		businessId	 	string  		店铺Id
 *		businessName	string		店铺名称
 *		address 		String		地址
 *		contactName 	string		联系人
 *		phone			string		联系电话
 *	  }
 * }
 *
 */
+(NSString *)getProductSourceDetailByBusinessProduct; // OK

/**
 * @see 获取货源详细
 * @author kai.li
 *  @param	 productSourceId	string	货源id
 
 * @return  data:{
 * 	code:  true:code=0,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 			productSource
 * 				{
 * 						productSourceId  string   货源ID
 * 						image 			 string	     图片
 * 						productSourceTitle  string 标题
 * 						validEndDate     string   失效日期
 *                       vailidStartDate    string   开始日期
 *                       unit               string   单位
 *                       price				string	金额
 *                       businessId			string  商铺ID
 *                       detail				string	详细
 * 				}
 *
 *
 * 	}
 */
+(NSString *)getProductSource; // ok 我的：我的货源：货源商城：点击右侧cell: 请求数据

/**
 * @see 获取货源下单列表
 * @author kai.li
 *  @param	 businessId	string	行业类别           行业类别  多个用英文“,”逗号隔开
 *  @param    currentPageNum	String			当前页面数
 *  @param	pageSize		String			获取数据数
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 			productList[
 * 				{
 * 						productSourceId  string   货源ID
 * 						image 			 string	     图片
 * 						productSourceTitle  string 标题
 * 						validEndDate     string   失效日期
 *                       vailidStartDate    string   开始日期
 *                       unit               string   单位
 *                       price				string	金额
 *                       businessId			string  商铺ID
 *                       detail				string	详细
 * 				},{...}
 * 			]
 * 		}
 */
+(NSString * )orderProductionSourceList;

/**
 * 新增货源
 * @param image 			  string   图片
 * @param productSourceTitle  string   标题
 * @param validEndDate        string   失效日期
 * @param vailidStartDate     string   开始日期
 * @param industryId          string   行业
 * @param unit                string   单位
 * @param price               string   金额
 * @param businessId		  string   商铺ID
 * @param detail			  string   详细
 * @return  data:{
 * 	code: true:code=200,false:code!=200
 * 	dataCode:   number	返回非错误逻辑性异常code
 * 	resultMsg:  string 	返回信息
 * 	totalCount: int     返回总条数
 * 	data:{
 * 		}
 * 	}
 */
+(NSString *)getAddProductSourceUrl; // PT

/**
 * @see 删除货源
 * @param			productSourceId  string   货源ID
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		}
 * 	}
 */
+(NSString *)getDelProductSourceUrl;//OK

/**
 * @see 获取货源列表 货源商城

 *  @param	cateId	string	行业类别
 *  @param  currentPageNum	String			当前页面数
 *  @param	pageSize		String			获取数据数
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 			productList[
 * 				{
 * 						productSourceId  string   货源ID
 * 						image 			 string	     图片
 * 						productSourceTitle  string 标题
 * 						validEndDate     string   失效日期
 *                       vailidStartDate    string   开始日期
 *                       unit               string   单位
 *                       price				string	金额
 *                       businessId			string  商铺ID
 *                       detail				string	详细
 * 				},{...}
 * 			]
 * 		}
 * 	}
 */
+(NSString *)getProductSourceListUrl; // ok 我的：我的货源：货源商城：点行行业列表cell

/**
 *  我的店铺详情
 *  @param businessId
 *  @return 我的店铺详情
 */
// + (NSString *)getBusinessInfoUrl;


/**
 * @see 获取货源特惠
 * @author kai.li
 *  @param	 userId	      string	用户ID
 *  @param   businessId	  String	门店ID
 *  @param   industryId   string    行业类别
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 			productList[
 * 				{
 * 						productSourceId  string   货源ID
 * 						image 			 string	     图片
 * 						productSourceTitle  string 标题
 * 						validEndDate     string   失效日期
 *                       vailidStartDate    string   开始日期
 *                       unit               string   单位
 *                       price				string	金额
 *                       businessId			string  商铺ID
 *                       detail				string	详细
 * 				},{...}
 * 			]
 * 		}
 * 	}
 */
//@RequestMapping(value="/productSource/getProductSourcepReference.do")
+(NSString *)getProductSourcepReferenceUrl;

#pragma mark ************************广告*************************
/**
 *  获取所有广告
 *  @param  type:   string	     (0:公司内部广告－首页广告，1：我的－货源 2：服务商城 3：财务室 4： 理财 5:管理中心)
 *  @return
 */
+(NSString *)getAdvertismentURL;
#pragma mark ************************服务商城*************************
/**
 *  服务商城
 *
 *  @return urlString
 */
+(NSString *)getServiceMallUrl; // OK

/**
	* 获取未下载服务商城列表
	* @param userId	string  用户ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:[
 * 		{
 * 			mallId		int	  		服务商城ID
 * 			mallName	string		服务商城名
 * 			detail		string		服务商城详细
 * 			downloadCount	int		下载次数
 * 			is_commoned		int		是否被推荐
 * 			position		int		显示位置
 * 		},{...}
 * 	]
	*	}
	*/
+(NSString *)getMoreServerMallUrl;

/**
	* 获取已有服务商城列表
	* @param userId	string  用户ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:[
 * 		{
 * 			mallId		int	  		服务商城ID
 * 			mallName	string		服务商城名
 * 			detail		string		服务商城详细
 * 			downloadCount	int		下载次数
 * 			is_commoned		int		是否被推荐
 * 			position		int		显示位置
 * 		},{...}
 * 	]
	*	}
	*/
+(NSString *)getMySelfServerMallUrl; // OK


/** OK
	* @see 获取服务商城列表
	* @author kai.li
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:[
 * 		{
 * 			mallId		int	  		服务商城ID
 * 			mallName	string		服务商城名
 * 			detail		string		服务商城详细
 * 			downloadCount	int		下载次数
 * 			is_commoned		int		是否被推荐
 * 			position		int		显示位置
 * 		},{...}
 * 	]
	*	}
	*/
+(NSString *)getServerMallListUrl; // OK

#pragma mark ************************管理中心**********************
/**
 *  获取服务商城 线上服务
    参数：userId
 */
+(NSString *)getServeMarket;


//order/getTenOrderList.do
/* @see 获取最近完成的十笔交易列表
* @param businessId
*            string 门店ID
* @return data:{ code: true:code=200,false:code!=200 dataCode: number
    *         返回非错误逻辑性异常code resultMsg: string 返回信息 totalCount : int 返回总条数
    *         data:{ orderList:[{ orderId string 订单号, businessId:{ businessId
        *         店铺Id businessName 店铺名称 }, userId String 用户Id, diskId int 座号Id,
        *         price double 总价, plantformId int 终端类型, payment int 支付方式, needs
        *         string 特别需要, status int 状态, description string 描述, userName
        *         string 收货人姓名, adress string 收货人地址, phone string 收货人电话, type int
        *         是否支付 0：false,1:true },{...}] }
    */
+(NSString *)getTenOrderList;
#pragma mark ************************产品管理*************************
#pragma mark -店铺下的所有商品-
/**
 * @see 获取店铺下的所有商品
	* @author kai.li
	*   @param  businessId 	String	店铺Id
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 		product[
 * 				{
	* 				productId			string  商品编号,
	* 				productName			string	商品名称,
	* 				position			int		商品显示位置,
	* 				majorInfoId			int		所属行业类别,
	* 				cateId				int		产品类别,
	* 				unit				string	单位,
	* 				isRecommended		int		是否被推荐0：false,1:true
	* 				isOnsale			int	            是否在线出售0：false,1:true
	* 				description			string  详细,
	* 				specialType[{"在线","0.5元"},{"线下","0.4元"}...]   特价类型,
	* 				icon				string	图片
 * 				},{....}
 * 		]
 * 	}
	* }
 */

+(NSString *)getProductList;
#pragma mark -新增产品-
/**
 * @see 新增产品（B端）
	* @author kai.li
	*   	@param  imageList		string    图片多个以英文','逗号拼接
	*    	@param  type			string    产品类型
	*    	@param  serviceType		string    服务类型
	*       @param  startTime		string    开始时间
	*       @param  endTime			string    结束时间
	*       @param  isPay			string    是否需要预支付
	*       @param  productName		string    服务名称
	*       @param  detail			string    服务详细
    *       @param  price 			string
    *       @param  unit 			string
    *       @param  businessId 	    string
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:[{
 * 	}]
	* }
 */
+(NSString * )addProductInfo;
/**
 * 产品仓库
 * @see 获取店铺下的所有产品池数据
	*   @param  businessId 	String	店铺Id
 *	@param  currentPageNum	int			当前页面数
 *	@param	pageSize		int			获取数据数
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 		product[
 * 				{
	* 				productPoolId		string  商品池编号,
	* 				createTime			string  创建时间
	* 				updateTime			string  修改时间
	* 				productPoolName		string	商品名称,
	* 				position			int		商品显示位置,
	* 				industryId			int		所属行业类别,
	* 				cateId				int		产品类别,
	* 				unit				string	单位,
	* 				isRecommended		int		是否被推荐0：false,1:true
	* 				isOnsale			int	            是否在线出售0：false,1:true
	* 				description			string  详细,
	* 				icon				string	图片
	* 				isActive			int	           是否特价
	* 				stauts				int	           产品池中产品状态				},{....}
 * 		]
 * 	}
	* }
 */
+(NSString *)getProductPoolByBusinessUrl;
/**
 *  发布产品 WEB VIEW
 *
 *  @return urlString
 */
+(NSString *)getCommitProductUrl;
#pragma mark ************************店员管理*************************
/**
	* 获取店铺员工列表
	* @param	businessId		string   店铺ID
	* @return  data:{
    * 	code:  true:code    = 200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 		salesclerkList[
 * 			{
 * 				alesclerkId		int			员工ID
 * 				alesclerkName	string		员工姓名
 * 				alesclerkBank	string		员工卡号
 * 				businessId		string		门店ID
 * 				alesclerkSex	int			员工性别
 * 				alesclerkPhone	string		电话
 * 				alesclerkAddress	string	地址
 * 			    alesclerkDetail		string	描述
 * 				salesclerkImg		string  店员头像
 * 			},{...}
 * 		]
 * 	}
 * }
 */
+(NSString *)getSalesclerkListByBusinessUrl;//OK

/**
 *  修改员工信息
 *  @param  	alesclerkId		int			员工ID
 * 	@param		alesclerkName	string		员工姓名
 * 	@param		alesclerkBank	string		员工卡号
 * 	@param		businessId		string		门店ID
 * 	@param		alesclerkSex	int			员工性别
 * 	@param		alesclerkPhone	string		电话
 * 	@param		alesclerkAddress	string	地址
 * 	@param		alesclerkDetail		string	描述
 * 	@param		salesclerkImg		string  店员头像
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 	}
	* }
	*/
+(NSString *)getUpateSalesclerkUrl;//OK

/**
	* 删除员工信息
	*   @param  	alesclerkId		int	[]		员工ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 	}
	* }
	*/
+(NSString *)getDelSalesclerkUrl;//OK


/**
 *新增员工信息                                                是否必传
 *  @param		alesclerkName	string		员工姓名            Y
 * 	@param		alesclerkBank	string		员工卡号            N
 * 	@param		businessId		string		门店ID             Y
 * 	@param		alesclerkSex	int			员工性别            N
 * 	@param		alesclerkPhone	string		电话               Y
 * 	@param		alesclerkAddress	string	地址               N
 * 	@param		alesclerkDetail		string	描述               N
 * 	@param		salesclerkImg		string  店员头像            Y
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 	}
	* }
	*/
+(NSString *)getAddSalesclerkUrl;//OK
#pragma mark ************************交易管理*************************
/**
 * @see B端修改订单状态---接受订单，拒绝订单
	* @author kai.li
	* 	@param 	orderId	string 门店ID
	* 	@param 	status	string	   状态
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
	* 	}
 */

+(NSString *)updateOrderStatuUrl;//OK
/**
	* @see 修改店铺产品池状态－－－修改产品商品服务后会新增一条与该产品一样的商品服务
	* @author kai.li
	*   @param  productPoolId 	String	产品池产品ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 	}
	* }
	*/
+(NSString *)updateProductPoolStatus;//OK
/**
 *  交易管理
 *
 * @param businessId
 *            string 订单Id(必需)
 * @param startTime
 *            string 产品Id(可空)
 * @param endTime
 *            string 店铺Id(可空)
 * @param status
 *            String 状态Id(可空)
 * @param currentPageNum
 *            string 当前页面数 (currentPageNum和pageSize都为0时表示不分页)
 * @param pageSize
 *            string 获取数据数 (currentPageNum和pageSize都为0时表示不分页)
 */
+(NSString *)getOrderListByBusinessIdDateStatuUrl;
/**
 * @see 查看订单详细
	* @author kai.li
	* 	@param  orderId		string	订单Id(非必需)
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
	* 	dataCode: number	返回非错误逻辑性异常code
	* 	resultMsg: string 	返回信息
	* 	totalCount : int	返回总条数
 * 	data:{
 * 		order:{
 * 			orderCreateTime		String		订单创建时间
	*			orderUpdateTime		String		订单更新时间
	*			orderId				String		订单ID
	*			plantformId			String		平台号
	*			businessId			String		店铺ID
	*			businessName		String		店铺名
	*			userId				String		用户Id
	*			sessionKey			String		sessionKey
	*			deskId				String		桌号
	*			orderPrice			String		订单金额
	*			payment				String		支付方式
	*			needs				String		特别需求
	*			orderStatus			String		订单状态
	*			orderDescription	String		订单描述
	*			userName			String		送货人名
	*			phone				String		联系人电话
	*			isPaid				String		是否支付
	*			isFlag				String		是否可用
	*			address				String		送货地址
	*			orderItemCreateTime	String		订单子项创建时间
	*			orderItemUpdateTime	String		订单子项更新时间
	*			productId			String		商品ID
	*			orderItemNum		String		订单子项商品数量
	*			orderItemAmount		String		订单子项商品总额
	*			productCreateTime	String		商品创建时间
	*			productUpdateTime	String		商品更新时间
	*			productName			String		商品名
	*			productPosition		String		商品顺序
	*			productMajorInfoId	String		商品所属行业类别id
	*			productCateId		String		商品分类Id
	*			productUnit			String		商品单位
	*			productIsRecommendedString		是否推荐商品
	*			productIsOnsale		String		商品是否在售
	*			productDescription	String		商品描述
	*			productSpecialType	String		特价类型[{"在线","0.5元"},{"线下","0.4元"}...]
	*			productIcon			String		商品图片地址
	*			productIsActive		String		是否有特价
	*			productIsFlag		String		是否删除。0：显示，1：删除
 * 	}
 * }
	*}
 */
+(NSString *)getOrder;

/**
 *  查询微信订单状态
 *  @param   orderId	string 订单号
 *  @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{ 
        urlCode:XXXXX
    }
 *
 */
+(NSString *)orderQuery;
#pragma mark ************************会员管理*************************
/**
	* 查询所有的会员卡等级
	* @param  	businessId		string		门店ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		   levelList[
 * 				{
 * 					levelId 	int			会员卡编号
 * 					levelName	string		会员等级名称
 * 					businessId	string		门店ID
 * 					bDiscount	float		折扣
 * 					levelDetail	string		描述
 * 				},{...}
 * 			]
	* 	}
	*/
+(NSString *)getAssociatorLevelListUrl;//OK

/**
	* 查询门店下的所有会员
	* @param  	businessId		string		门店ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		    associatorList[
 * 				{
 * 					id		int			会员卡编号
 * 					name 	int			姓名
 * 					sex		int			性别
 * 					phone	string		电话
 * 					address	float		地址
 * 					level	string		等级
 * 					detail	string		描述
 * 					isActive  int		是否活跃状态
 * 				},{...}
 * 			]
	* 	}
	*/
+(NSString *)getAssociatorUrl;//OK
/**
 *@see 修改会员卡等级
	*		@param			levelId 	int	会员卡编号
 * 		@param			levelName	string		会员等级名称
 * 		@param			bDiscount	float		折扣
 * 		@param			price		float		最低消费
 * 		@param			levelDetail	string		描述
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
	* 	}
     @RequestMapping(value="/associator/updateAssociatorLevel.do")
 */
+(NSString *)changeVIPInfo;//OK


/**
	*   开启关闭会员卡
	*	@param  	levelId		string			会员卡ID
	* 	@param  	status		string			状态
	* 	@return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
+(NSString *)getOpenOrCloseLevelUrl;//OK

/**
	*    审核会员申请状态
	*	@param  	associatorId	string		会员卡ID
	*	@param  	status		string			状态  会员状态  1：通过 ，2：拒绝
	* 	@return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
+(NSString *)getUpdateApplyStatusUrl;//OK
/**
	* @see	查询门店下不同等级会员
	*	@param  	businessID		string		门店ID
	*	@param  	level			string		会员等级
	*   @param    currentPageNum	string			当前页面数
	*   @param	pageSize		 string			获取数据数
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		    associatorList[
 * 				{
 * 					id		int			会员卡编号
 * 					name 	int			姓名
 * 					sex		int			性别
 * 					phone	string		电话
 * 					address	float		地址
 * 					level	string		等级
 * 					detail	string		描述
 * 					isActive  int		是否活跃状态
 * 				},{...}
 * 			]
	* 	}
	*/
//@RequestMapping(value="/associator/getAssociatorByBusinessAndLevel.do")
+(NSString *)getAssociatorByBusinessAndLevel;

#pragma mark ----根据电话号码检索会员-----
/**
	* @see 根据电话号码检索会员
	* @author kai.li
	*	@param  	phone   	string		电话号码
	*   @param    currentPageNum	string			当前页面数
	*   @param	pageSize		 string			获取数据数
	* 	@return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
//@RequestMapping(value="/associator/getAssociatorByPhone.do")
+(NSString *)getAssociatorByPhone;//OK

#pragma mark --- 删除会员 ---
/**
	* @see 删除会员
	* @author kai.li
	*	@param  	id		int			会员ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
//@RequestMapping(value="/associator/delAssociator.do")
+(NSString *)delAssociator;

#pragma mark -- 修改会员--
/**
	* @see 修改会员
	* @author kai.li
	*	@param  	id		int			会员ID
 * 	@param		phone	string		电话
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
//@RequestMapping(value="/associator/updateAssociator.do")
+(NSString *)updateAssociator;
#pragma mark ********************体现***************
/**
	* @see	提现
	* @author kai.li
	*	@param	userid		string		用户ID
	*	@param	banknum		string		银行卡号
	*	@param	payPwd		string		支付密码
	*	@param	amount		string		金额
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/

+(NSString *)withdrawUrl;
#pragma mark **********************银行卡***************
/**
 * @see	余额
 * @author kai.li
 * @param userId		String		用户ID
 */
//@RequestMapping(value="/transaction/getBalance.do" )
+(NSString * )getBalanceUrl;
/**
 *  忘记密码，获取验证码
 * @param userId
 *            string 用户ID
 * @param bankNum
 *            string 银行卡号
 *
 */
+(NSString *)sendUpdatePasswordCodeUrl;
/**
 *  账户明细
 *
 *  @param userId  String 用户ID
 */
+(NSString * )getWithDrawByUserIdUrl;

//@RequestMapping(value="/bank/getBankList.do" )
/**
 *  获取银行卡
 *
 *  @param		userId		string		用户ID
 */
+(NSString *)getBankListUrl;
/**
 *  绑定银行卡
 *
 *	@param  	bankNum			string		卡号ID
 * 	@param		bankName		string		卡名称
 * 	@param		contactName		string 		联系人
 * 	@param		paypwd			string		支付密码
 * 	@param		phone			string		电话号码
 * 	@param		userId		string		用户ID
 * 	@param		 bankId			string		银行卡类型
 */
+(NSString *)addBankUrl;
/**
 *  修改银行卡密码
 *
 *  @param  userId		string		用户ID
 *	@param 	bankID		string  卡ID
 *	@param 	password	string  密码
 *	@param	rePassword	string	重复密码
 */
+(NSString *)updateBankPasswordUrl;

/**
 *  忘记银行卡密码
 *
 * 	@param  userId		string		用户ID
	* 	@param  bankNum     string		银行卡号
	* 	@param	code		string		验证码
	* 	@param	password	string		密码
	* 	@param	repassword	string		重复密码
 */
+(NSString *)forgetPasswordUrl;
/**
 *  删除银行卡
 *
 *	@param  userId		string		用户ID
 *	@param 	bankID		string  卡号
 *	@param 	password	string  密码
 */
+(NSString *)delBankUrl;
/**
 *  获取银行列表
 */
+(NSString *)getAllBankUrl;

/**
	* @see 是否一开通过英航卡信息
	* @author kai.li
	* 	@param  userId		string		用户ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
	1有0mei有
	*/
//@RequestMapping(value="/bank/getIsTrue.do" )
+(NSString *)getIsTrueUrl;

#pragma mark ************************财务室*************************
#pragma mark ***********经营收入**********
/**
	* @see 获取某月线下经营总收入
	*	@param	businessId	string			店铺ID
	*	@param	datetime	string			日期
	*/

+(NSString *)getOfflineCountByMonthUrl;//OK

/**
	* @see 获取某月线上经营总收入
	*	@param	businessId	string			店铺ID
	*	@param	datetime	string			日期
	*/
+(NSString *)getOnlineCountByMonthUrl;//OK
/**
	* @see 获取上周的线下经营总收入
	* @author kai.li
	*	@param	businessId	string			店铺ID
	*/

+(NSString *)getOfflineLastWeekCountUrl;//OK



/**
	* @see 获取上周的线上经营总收入
 *	@param	businessId	string			店铺ID
	*/
//@RequestMapping(value="/transaction/getOnlineLastWeekCount.do" )
+(NSString *)getOnlineLastWeekCountUrl;//ok

/**
 *  * @see 获取线上经营总收入
 *	@param	BusinessId	string			店铺ID
 */
+(NSString *)getOnlineCountByBusinessUrl;


/**
	* @see 获取线下经营总收入
	*	@param	BusinessId	string			店铺ID
	
 */
+(NSString *)getOfflineCountByBusinessUrl;

/**
 * @see 获取线下每天不同时间段的经营收入
 * @param businessId
 *            string 店铺ID
 * @param datetime
 *            string 日期
 */
+(NSString *)getOfflineCountByTwoHoursUrl;

/**
 * @see 获取线上每天不同时间段的经营收入
 * @param businessId
 *            string 店铺ID
 * @param datetime
 *            string 日期
 */
+(NSString *)getOnlineCountByTwoHoursUrl;

/**
	* @see 获取线上每天收入明细
	* @author kai.li
	*	@param	businessId	string			店铺ID
	*	@param	datetime	string			日期	}
	*/
//@RequestMapping(value="/transaction/getDetailOnline.do" )
+(NSString *)getDetailOnlineUrl;


/**
	* @see 获取线下每天收入明细
	*	@param	businessId	string			店铺ID
	*	@param	datetime	string			日期
	*/
+(NSString *)getDetailofflineUrl;

/**
	* @see 获取上周每日收入数据
	*	@param	businessId	string			店铺ID
	*/
+(NSString *)getAmountByWeekUrl;
/**
	* @see 获取本年每月收入数据
	*	@param	businessId	string			店铺Id
	*/
+(NSString *)getAmountByMonthUrl;

/**
	* @see 获取经营总收入
	* @param	businessId	string			店铺ID
	*/
+(NSString *)getCountByBusiness;

/**
	* @see 获取某天经营总收入
    *	@param	businessId	string			店铺ID
	*	@param	dateTime	string			日期（YYYY-mm-dd）
    *   @param	type	string			类型
	*/
// type:
// 0：今天总收入
// 1：今天在线收入
// 2：到店收入
+(NSString *)getCountByDay;

#pragma mark ************************功能介绍WebView*************************
/**
 *  clerk 		            -    店员管理
 *  finance 				- 	 财务管理
 *  financialTransactions 	-    我要理财
 *  manage					-	 经营收入
 *  material 				-	 我的资料
 *  mySource 				-	 我的货源
 *  news 					-	 我的消息
 *  other					-	 其他功能
 *  product					-	 产品管理
 *  server					-	 服务商场
 *  shops 					-	 切换商铺
 *  source 					-	 货源商城
 *  store					- 	 我的店铺
 *  sweep					-	 扫一扫
 *  trade					-	 交易管理
 *  vip 					-	 会员管理
 *  order                   -    订单中心
 */
+(NSString *)getIntroduceUrl;

/**
 * @see 添加货源线下订单 我的：：我的货源：：货源商城：：右击右侧tableView的cell：：进入货源详情：：点击确认下单
 * @author kai.li
 * @param  productSrouceId	string 货源ID
 *	@param  businessId	string     店铺Id
 *	@param  buyBusinessId string 购买店铺ID
 *	@param	orderPrice	string	订单总价
 *	@param	plantformId	string	终端类型
 *	@param	userName	string	收货人姓名
 *	@param	phone		string	收货人电话
 *	@param	address	string		地址
 *	@param	amount	string		货源总价
 *	@param	price	string		货源价格
 *	@param	num	string		货源数量
 * @return  data:{
 * 	code:  true:code=200,false:code!=200
	dataCode: number	返回非错误逻辑性异常code
	resultMsg: string 	返回信息
	totalCount : int	返回总条数
    data:{
        orderId	string  订单号
    }
*   }
*/
+ (NSString *)addProductSourceOrderUrl; // 未通 我的：：我的货源：：货源商城：：点击右侧cell:: 点击提交订单：：点击确认订单


#pragma mark ====饼状图，柱状图，扇形图=====
+(NSString *)pictureForIncomeUrl;


#pragma mark ************************支付接口*************************
/**
	* @see 刷卡支付(根据扫出来的编号获取相应的数据)(b扫c）
	* @author kai.li
	* 	@param  	sweepStr		string			商户扫描获取的微信商户编码
	* 	@param  	amount			string			金额
	*/
+(NSString *)getSweepPushCardUrl;


/**
	* @see 扫码支付（c扫b）
	* @param   amount	string 	金额
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 urlCode:XXXXX
 *  		}
	* 	}
	*/
+ (NSString *)getPaymentSweepPayUrl;
@end
