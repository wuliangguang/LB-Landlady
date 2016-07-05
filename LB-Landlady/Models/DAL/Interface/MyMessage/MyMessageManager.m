//
//  MyMessageManager.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageManager.h"
#import "URLService.h"
#import "CommonModel.h"
#import "MyMessageDataModel.h"
#import "RootViewController.h"
#import "UITabBar+ZZCustomBadge.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface MyMessageManager ()

@property (nonatomic, copy) void (^messageHandler)(NSArray *array);

+ (instancetype)sharedManager;
- (void)getMessageWithHandler:(void (^)(NSArray *messageArray))messageArray;
@end

@implementation MyMessageManager

static MyMessageManager *_manager = nil;

+ (void)handleMessage {
    // [self handleMessageWithCallback:nil];
    [self handleMessageWithCallback:^(NSArray *messageArray) {
        NSInteger count = 0;
        for (MyMessageModel *message in messageArray) {
            if (message.is_read == NO) {
                ++count;
            }
        }
        
        UITabBarController *tabController = (UITabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        NSLog(@"%@", tabController);
        if ([tabController isKindOfClass:[RootViewController class]] == NO) {
            return ;
        }
        if (count > 0) {
            [tabController.tabBar showBadge];
        } else {
            [tabController.tabBar hideBadge];
        }
    }];
}

+ (void)handleMessageWithCallback:(void (^)(NSArray *messageArray))messageHandler {
    [[MyMessageManager sharedManager] getMessageWithHandler:messageHandler];
}

+ (instancetype)sharedManager {
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        _manager = [[MyMessageManager alloc] init];
    });
    return _manager;
}

- (void)getMessageWithHandler:(void (^)(NSArray *messageArray))messageHandler {
    if (App_User_Info.haveLogIn == NO || App_User_Info.myInfo.userModel.defaultBusiness.length <= 0) {
        return;
    }
    self.messageHandler = messageHandler;
    NSDictionary *parameters = @{
                           @"businessId" : App_User_Info.myInfo.userModel.defaultBusiness,
                           @"currentPageNum" : @"0",
                           @"pageSize" : @"20"
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[URLService getMessageListUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MyMessageDataModel class]];
        if (commonModel.code != SUCCESS_CODE) {
            return ;
        }
        MyMessageDataModel *dataModel = commonModel.data;
        NSArray *messageArray = dataModel.message;
       
        /**
        RootViewController *root = (RootViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        if (messageArray.count > 0) {
            root.redPointView.hidden = NO;
        } else {
            root.redPointView.hidden = YES;
            return;
        }*/
        
        if (self.messageHandler) {
            self.messageHandler(dataModel.message);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
}

@end
