//
//  CustomQrCode.h
//  CustomQRCode
//
//  Created by d2space on 14-12-15.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomQrCode : NSObject

+ (UIImage *)createQRCodeWithValue:(NSString *)qrContent WithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue WithSize:(CGFloat)size;

@end
