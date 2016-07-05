//
//  BasicUserInfo.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyInfo : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *lastLogin;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *defaultBusiness;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *urgent;
@property (nonatomic, copy) NSString *urgentPhone;
@property (nonatomic, copy) NSString *userImage;
@property (nonatomic, copy) NSString *password;
@property (nonatomic,copy ) NSString *nickName;
@property (nonatomic,copy ) NSString *userImageThumb;
@end
