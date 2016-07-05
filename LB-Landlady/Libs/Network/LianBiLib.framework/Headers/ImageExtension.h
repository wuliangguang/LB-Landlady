//
//  ImageExtension.h
//  BlurImageDemo
//
//  Created by d2space on 15-1-15.
//  Copyright (c) 2015年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageExtension : NSObject
//模糊效果
+ (UIImage *)imgBlurEffectWithImage:(UIImage *)image;
+ (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor WithImage:(UIImage *)image;

@end
