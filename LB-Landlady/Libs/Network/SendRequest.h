//
//  SendRequest.h
//  AFNetwork_Demo
//
//  Created by d2space on 15/12/9.
//  Copyright © 2015年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum p_type
{
    POST_ARR,
    POST_IMAGE,
    POST_ALL
}Post_Type;


@interface SendRequest : NSObject<UIAlertViewDelegate>

@property (nonatomic, assign) Post_Type        postType;

/**
 *  单例
 *
 *  @return self
 */
+ (instancetype)sharedInstance;

/**
 *  POST请求
 *
 *  @param url        访问url:String
 *  @param params     需传参数：Dictionary
 *  @param success    成功callback
 *  @param failure    失败callback
 *  @param controller 当前视图控制器
 */
- (void)LB_PostWithURLString:(NSString *)url
                  WithParams:(NSDictionary *)params
                 WithSuccess:(void(^)(id responseObject,id responseString))success
                     failure:(void(^)(NSError *error))failure
              WithController:(UIViewController *)controller;

/**
 *  GET请求
 *
 *  @param url        访问url:String
 *  @param params     需传参数：Dictionary
 *  @param success    成功callback
 *  @param failure    失败callback
 *  @param controller 当前视图控制器
 */
- (void)LB_GetWithURLString:(NSString *)url
                 WithParams:(NSDictionary *)params
                WithSuccess:(void(^)(id responseObject,id responseString))success
                    failure:(void(^)(NSError *error))failure
             WithController:(UIViewController *)controller;

/**
 *  POST请求，用formData传数据，one KEY more Value
 *
 *  @param url        访问url:String
 *  @param pt         查阅Post_Type ENUM
 *  @param params     需传参数：Dictionary
 *  @param dataParams 需传参数：Dictionary,formdata部分数据
 *                            @{key:@[nsdata]}
 *  @param success    成功callback
 *  @param failure    失败callback
 *  @param controller 当前视图控制器
 */
- (void)LB_PostWithURLString:(NSString *)url
                    postType:(Post_Type)p_type
                  parameters:(NSDictionary *)params
                    WithData:(NSDictionary *)dataParams
                     success:(void(^)(id responseObject))success
                     failure:(void(^)(NSError *error))failure
        senderViewController:(UIViewController *)controller;



/**
 *  检查更新
 *
 *  @param appid 应用id
 */
- (void)appCheckUpdate:(NSInteger)appid;
@end
