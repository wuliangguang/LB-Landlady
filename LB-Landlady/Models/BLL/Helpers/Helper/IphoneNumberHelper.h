//
//  IphoneNumberHelper.h
//  MeZoneB
//
//  Created by d2space on 15/6/1.
//  Copyright (c) 2015年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IphoneNumberHelper : NSObject
+ (BOOL)iphoneNumberInputRule:(NSString *)contentString InputString:(NSString *)inputString;
@end
