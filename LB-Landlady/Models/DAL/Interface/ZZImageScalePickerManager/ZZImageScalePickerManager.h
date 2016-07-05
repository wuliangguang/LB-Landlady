//
//  ZZImageScalePickerManager.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPViewController.h"

@interface ZZImageScalePickerManager : NSObject <VPViewControllerDelegate>

+ (void)pickImageWithCallback:(void (^)(UIImage *image))callbackHandler;

/**
 *  封装图片拾取，基于VPViewController, 默认比便1:1
 *
 *  @param callbackHandler 返回拾取的图片对象
 */
+ (void)pickImageWithScale:(CGSize)scale callback:(void (^)(UIImage *image))callbackHandler;

@end
