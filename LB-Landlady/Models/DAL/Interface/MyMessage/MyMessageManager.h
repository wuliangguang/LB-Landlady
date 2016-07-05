//
//  MyMessageManager.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessageManager : NSObject

+ (void)handleMessage;
+ (void)handleMessageWithCallback:(void (^)(NSArray *messageArray))messageHandler;

@end
