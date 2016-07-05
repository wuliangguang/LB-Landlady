//
//  SendRequest.m
//  AFNetwork_Demo
//
//  Created by d2space on 15/12/9.
//  Copyright © 2015年 Lianbi.com.cn. All rights reserved.
//

#import "SendRequest.h"
#import <LianBiLib/NSData+AESEncryption.h>
#import <LianBiLib/Base64+Custom.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "StatusCode.h"
#import "MBProgressHUD.h"
#import "LoginManager.h"


@interface SendRequest()
/**
 *  AFNetwork Request Manager
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
/**
 *  当前的视图控制器
 */
//@property (nonatomic, strong) UIViewController              *currentVController;
/**
 *  CSRFTOKEN模式下，请求的次数，当发生CSFRTOKEN错误403时，默认递归一次
 */
@property (nonatomic, assign) NSInteger                     requestNumb;

/**
 *  AES是否加密开关
 */
@property (nonatomic, assign) BOOL                          IS_AES;
/**
 *  AES加密开启，必须设置AES_KEY
 */
@property (nonatomic, strong) NSString                      *AES_KEY;
/**
 *  DES加密开关
 */
@property (nonatomic, assign) BOOL                          IS_DES;
/**
 *  DES加密开启，必须设置DES_KEY
 */
@property (nonatomic, strong) NSString                      *DES_KEY;
/**
 *  DES加密开启，必须设置DES_IV
 */
@property (nonatomic, strong) NSString                      *DES_IV;
/**
 *  CSRFTOKEN加密开关
 */
@property (nonatomic, assign) BOOL                          IS_CSRFTOKEN;
/**
 *  APP Store AppURL
 */
@property (nonatomic, strong) NSString       *updateUrl;

@property (nonatomic, strong) MBProgressHUD  *hud;
@end
@implementation SendRequest
+ (instancetype)sharedInstance
{
    static SendRequest *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
//        sharedInstance.IS_AES
//        sharedInstance.AES_KEY
//        sharedInstance.IS_DES
//        sharedInstance.DES_KEY
//        sharedInstance.DES_IV
//        sharedInstance.IS_CSRFTOKEN = YES;
    });
    return sharedInstance;
}
- (void)LB_PostWithURLString:(NSString *)url
                  WithParams:(NSDictionary *)params
                 WithSuccess:(void(^)(id responseObject,id responseString))success
                     failure:(void(^)(NSError *error))failure
              WithController:(UIViewController *)controller
{
    [self showHudWithMSG:nil WithController:controller];
    if (params != nil)
    {
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self creatRequestWith:url With:params]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *html       = operation.responseString;
            NSData* data         = [html dataUsingEncoding:NSUTF8StringEncoding];
            id dict              = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            NSDictionary *result = (NSDictionary *)dict;
            NSInteger status     = [result[@"code"] integerValue];

            if (status != SUCCESS_CODE) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self feedBackErrorStatusCN:result WithController:controller];
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.hud hide:YES];
                });
            }
            success(dict,operation.responseString);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (_IS_CSRFTOKEN )
            {
                NSHTTPURLResponse *response = error.userInfo[@"com.alamofire.serialization.response.error.response"];
                NSInteger errorCode = [response statusCode];
                if (errorCode == 403)
                {
                    NSURL *cookieUrl = [NSURL URLWithString:url];
                    if (cookieUrl)
                    {
                        if (_requestNumb == 0)
                        {
                            [self LB_PostWithURLString:url WithParams:params WithSuccess:success failure:failure WithController:controller];
                            _requestNumb++;
                            return;
                        }
                    }
                }
                else
                {
                    NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                    if (httpResponse.statusCode != 0)
                    {
                        [self showErrorInfoWith:httpResponse.statusCode VC:controller];
                    }
                    else
                    {
                        [self showErrorInfoWith:error.code VC:controller];
                    }
                   failure(error);
                }
            }
            NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
            if (httpResponse.statusCode != 0)
            {
                [self showErrorInfoWith:httpResponse.statusCode VC:controller];
            }
            else
            {
                [self showErrorInfoWith:error.code VC:controller];
            }
            failure(error);
        }];
        [_requestManager.operationQueue addOperation:operation];
    }
}

- (void)LB_GetWithURLString:(NSString *)url
                 WithParams:(NSDictionary *)params
                WithSuccess:(void(^)(id responseObject,id responseString))success
                    failure:(void(^)(NSError *error))failure
             WithController:(UIViewController *)controller
{
    
    [self showHudWithMSG:nil WithController:controller];
//    return; // 测试调试
    //url = [url stringByAppendingString:@"?platform=i"];
    _requestManager = [AFHTTPRequestOperationManager manager];
    NSURLRequest   *request = nil;
    if (params == nil)
    {
        request = [_requestManager.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:url relativeToURL:_requestManager.baseURL] absoluteString] parameters:nil error:nil];
    }
    else
    {
        request = [self creatRequestWith:url With:params];
    }
    
    _requestManager.requestSerializer.timeoutInterval = 12;
//    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSDictionary *result = (NSDictionary *)dict;
        NSInteger status = [result[@"code"] integerValue];

        if (status != SUCCESS_CODE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self feedBackErrorStatusCN:result WithController:controller];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.hud hide:YES];
            });
        }

        success(dict,operation.responseString);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self showErrorInfoWith:error.code VC:controller];
        failure(error);
    }];
    [_requestManager.operationQueue addOperation:operation];
}


- (void)LB_PostWithURLString:(NSString *)url
                    postType:(Post_Type)p_type
                  parameters:(NSDictionary *)params
                    WithData:(NSDictionary *)dataParams
                     success:(void(^)(id responseObject))success
                     failure:(void(^)(NSError *error))failure
        senderViewController:(UIViewController *)controller
{
    NSURLRequest *request = [self createAFRequestOperationWith:url With:params With:dataParams With:p_type];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSDictionary *result = (NSDictionary *)dict;
        NSInteger status = [result[@"status"] integerValue];
        
        if (status != SUCCESS_CODE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self feedBackErrorStatusCN:result WithController:controller];
            });
        }
        success(dict);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (_IS_CSRFTOKEN )
        {
            NSHTTPURLResponse *response = error.userInfo[@"com.alamofire.serialization.response.error.response"];
            NSInteger errorCode = [response statusCode];
            if (errorCode == 403)
            {
                NSURL *cookieUrl = [NSURL URLWithString:url];
                if (cookieUrl)
                {
                    if (_requestNumb == 0)
                    {
                        [self LB_PostWithURLString:url WithParams:params WithSuccess:^(id responseObject,id responseString) {
                            NSString *html = operation.responseString;
                            NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                            id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                            success(dict);
                        } failure:^(NSError *error) {
                            failure(error);
                        } WithController:controller];
                        _requestNumb++;
                        return;
                    }
                }
            }
            else
            {
                NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                if (httpResponse.statusCode != 0)
                {
                    [self showErrorInfoWith:httpResponse.statusCode VC:controller];
                }
                else
                {
                    [self showErrorInfoWith:error.code VC:controller];
                }
                failure(error);
            }
        }
        NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        if (httpResponse.statusCode != 0)
        {
            [self showErrorInfoWith:httpResponse.statusCode VC:controller];
        }
        else
        {
            [self showErrorInfoWith:error.code VC:controller];
        }
        failure(error);
    }];
    [_requestManager.operationQueue addOperation:operation];
}


#pragma mark ************************** Private Part
//初始化AFHTTPRequestOperation
- (NSURLRequest *)createAFRequestOperationWith:(NSString *)url With:(NSDictionary *)params With:(NSDictionary *)formDic With:(Post_Type)p_type
{
    NSDictionary *para = nil;
    if (params != nil)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        NSString *jsonStr = nil;
        if (!jsonData)
        {
            
            NSLog(@"Params Error");
        }
        else
        {
            NSString *jsStr = [[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            jsonStr = jsStr;
        }
        para = params;
        
        if (_IS_AES == YES && _IS_DES == NO)
        {
            NSData *paramesData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSData *resultData = [paramesData AESEncryptWithKey:_AES_KEY];
            NSString *baseString = [Base64 dataEncodeBase64ToString:resultData];
            para = [NSDictionary dictionaryWithObject:baseString forKey:@"content"];
        }
        else if (_IS_AES == NO && _IS_DES == YES)
        {
            
        }
        else if (_IS_AES == YES && _IS_DES == YES)
        {
            
        }
    }

//    url = [url stringByAppendingString:@"?platform=i"];
    
    NSString *urlStr = [[NSURL URLWithString:url relativeToURL:_requestManager.baseURL] absoluteString];
    NSMutableURLRequest *request = [_requestManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (p_type == POST_ALL)
        {
            //待完善
        }
        else
        {
            NSMutableArray *arr = [NSMutableArray array];
            NSString *keyString;
            for (NSString *str  in [formDic allKeys])
            {
                keyString = str;
                arr = formDic[str];
            }
            if (p_type == POST_IMAGE)
            {
                if (arr.count > 0)
                {
                    for (int i = 0; i < arr.count; i++)
                    {
                        [formData appendPartWithFileData:arr[i] name:keyString fileName:@"d2space.jpeg" mimeType:@"image/jpeg"];
                    }
                }
            }
            else
            {
                if (arr.count > 0)
                {
                    for (int i = 0; i < arr.count; i++)
                    {
                        [formData appendPartWithFormData:[arr[i] dataUsingEncoding:NSUTF8StringEncoding] name:keyString];
                    }
                }
            }
        }
    } error:nil];
    
    
    _requestManager.requestSerializer.timeoutInterval = 50;
    if (_IS_CSRFTOKEN == YES)
    {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
        __block NSString *token;
        if (cookies.count > 0)
        {
            for (int i= 0; i < cookies.count; i ++)
            {
                NSHTTPCookie *cookie= cookies[i];
                if ([cookie.name isEqualToString:@"csrftoken"])
                {
                    token = cookie.value;
                    break;
                }
            }
        }
        [request setValue:token forHTTPHeaderField:@"X-CSRFToken"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    }
    return request;
}
//初始化 request
- (NSURLRequest *)creatRequestWith:(NSString *)url With:(NSDictionary *)params
{
    NSDictionary *para = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *jsonStr = nil;
    if (!jsonData)
    {
        
        NSLog(@"Params Error");
    }
    else
    {
        NSString *jsStr = [[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        jsonStr = jsStr;
    }
    para = params;
    if (_IS_AES == YES && _IS_DES == NO)
    {
        NSData *paramesData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData *resultData = [paramesData AESEncryptWithKey:_AES_KEY];
        NSString *baseString = [Base64 dataEncodeBase64ToString:resultData];
        para = [NSDictionary dictionaryWithObject:baseString forKey:@"content"];
    }
    else if (_IS_AES == NO && _IS_DES == YES)
    {
        
    }
    else if (_IS_AES == YES && _IS_DES == YES)
    {
        
    }
    
//    url = [url stringByAppendingString:@"?platform=i"];
    _requestManager = [AFHTTPRequestOperationManager manager];
    NSMutableURLRequest *request = [_requestManager.requestSerializer requestWithMethod:@"post" URLString:[[NSURL URLWithString:url relativeToURL:_requestManager.baseURL] absoluteString] parameters:para error:nil];
    _requestManager.requestSerializer.timeoutInterval = 12;
    if (_IS_CSRFTOKEN == YES)
    {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
        __block NSString *token;
        if (cookies.count > 0)
        {
            for (int i= 0; i < cookies.count; i ++)
            {
                NSHTTPCookie *cookie= cookies[i];
                if ([cookie.name isEqualToString:@"csrftoken"])
                {
                    token = cookie.value;
                    break;
                }
            }
        }
        [request setValue:token forHTTPHeaderField:@"X-CSRFToken"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    }
    return request;
}

- (void)showHudWithMSG:(NSString *)msg WithController:(UIViewController *)controller
{
    NSLog(@"%@", msg);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hud == nil)
        {
            self.hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        }
        else
        {
            [controller.view addSubview:self.hud];
            // [self.hud hide:NO];
            [self.hud show:YES];
        }
        
        if (msg.length != 0)
        {
            self.hud.mode = MBProgressHUDModeText;
            self.hud.labelFont =[UIFont systemFontOfSize:13];
            self.hud.detailsLabelFont = [UIFont systemFontOfSize:13];
            self.hud.labelText = msg;
            [self.hud hide:YES afterDelay:ERROR_DELAY];
        }
        else
        {
            self.hud.mode = MBProgressHUDModeIndeterminate;
            self.hud.labelText = nil;
        }
    });
}

//请求成功：根据返回的errorcode显示响应的中文
- (void)feedBackErrorStatusCN:(NSDictionary *)responseObject WithController:(UIViewController *)controller
{
//    NSString *message = [StatusCode statusChangeCN:[responseObject[@"status"] integerValue]];

    NSString *message = responseObject[@"msg"];
    if (![message isKindOfClass:[NSNull class]])
    {
        if (message.length > 0)
        {
            [self showHudWithMSG:message WithController:controller];
        }
        else
        {
            [self.hud hide:YES];
        }
    }
}

//请求失败：
- (void)showErrorInfoWith:(NSInteger)statusCode VC:(UIViewController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hud == nil)
        {
            self.hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        }
        else
        {
//            self.hud.removeFromSuperViewOnHide = YES;
            [controller.view addSubview:self.hud];
            [self.hud show:YES];
        }
        
        self.hud.mode = MBProgressHUDModeText;
        
        if (statusCode == 401)
        {
            //            hub.labelText = errorInfo;
        }
        else if (statusCode == 500)
        {
            self.hud.labelText = @"服务器异常！";
        }
        else if (statusCode == -1001)
        {
            self.hud.labelText = @"网络请求超时，请稍候重试！";
        }
        else if (statusCode == -1002)
        {
            self.hud.labelText = @"不支持的URL！";
        }
        else if (statusCode == -1003)
        {
            self.hud.labelText = @"未能找到指定的服务器主！";
        }
        else if (statusCode == -1004)
        {
            self.hud.labelText = @"服务器连接失败！";
        }
        else if (statusCode == -1005)
        {
            self.hud.labelText = @"连接丢失，请稍候重试！";
        }
        else if (statusCode == -1009)
        {
            self.hud.labelText = @"互联网连接似乎是离线!";
        }
        else if (statusCode == -1012)
        {
            self.hud.labelText = @"操作无法完成！";//allowsInvalidSSLCertificate = yes
        }
        else
        {
            self.hud.labelText = @"网络请求发生未知错误，请稍候再试下吧！";
        }
        [self.hud hide:YES afterDelay:ERROR_DELAY];

        
    });
}

- (void)appCheckUpdate:(NSInteger)appid
{
    _requestManager = [AFHTTPRequestOperationManager manager];
    NSURLRequest   *request = [_requestManager.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%li",(long)appid] relativeToURL:_requestManager.baseURL] absoluteString] parameters:nil error:nil];
    _requestManager.requestSerializer.timeoutInterval = 12;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSArray *templeArr = (NSArray *)dict[@"results"];
        NSDictionary *releaseInfo = templeArr[0];
        NSString *appStoreVersion = releaseInfo[@"version"];
        self.updateUrl = releaseInfo[@"trackViewUrl"];
        NSArray *storeNumbs = [appStoreVersion componentsSeparatedByString:@"."];
        
        NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSArray *localNumbs = [localVersion componentsSeparatedByString:@"."];
//        if ([appStoreVersion isEqualToString:localVersion])
//        {
//            [LoginManager loginWithCompletionHandler:nil];
//            return ;
//        }
        for (int i = 0; i < localNumbs.count; i ++)
        {
            if (i < 2)
            {
                if ([localNumbs[i] integerValue] < [storeNumbs[i] integerValue])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"当前版本必须要更新喔" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        alert.tag = 3001;
                        [alert show];
                    });
                    break;
                }
                else if ([localNumbs[i] integerValue] == [storeNumbs[i] integerValue])
                {
                    continue;
                }
                else
                {
                    [LoginManager loginWithCompletionHandler:nil];
                    return;
                }
            }
            else
            {
                if ([localNumbs[i] integerValue] < [storeNumbs[i] integerValue])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"当前有版本需要更新喔" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        alert.tag = 3002;
                        [alert show];
                    });
                }
                else
                {
                    [LoginManager loginWithCompletionHandler:nil];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [LoginManager loginWithCompletionHandler:nil];
    }];
    [_requestManager.operationQueue addOperation:operation];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 3001)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
    }
    else
    {
        if (alertView.tag == 3002 && buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
        }
        else
        {
            [LoginManager loginWithCompletionHandler:nil];
        }
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 3001)
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
//    }
//    else
//    {
//        if (alertView.tag == 3002 && buttonIndex == 1)
//        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
//        }
//        else
//        {
//            [LoginManager loginWithCompletionHandler:nil];
//        }
//    }
//}
@end
