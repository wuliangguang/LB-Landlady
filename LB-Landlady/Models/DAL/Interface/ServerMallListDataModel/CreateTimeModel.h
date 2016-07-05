//
//  CreateTimeModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateTimeModel : NSObject

@property (nonatomic, assign) NSInteger date;
@property (nonatomic, assign) long long time;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hours;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger nanos;
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger timezoneOffset;
@end
