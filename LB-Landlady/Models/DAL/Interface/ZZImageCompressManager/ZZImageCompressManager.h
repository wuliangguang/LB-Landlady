//
//  ZZImageCompressManager.h
//  LB-Landlady
//
//  Created by 刘威振 on 2/29/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

/**
 *  此类暂时用不到，可删除
 */
@interface ZZImageCompressManager : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSData *data;

/**
 *  压缩图片(默认最大为500k Byte)
 *
 *  @param originImage 原始图片
 *
 *  @return 压缩后的图片
 */
+ (ZZImageCompressManager *)compressImage:(UIImage *)originImage;

/**
 *  压缩图片
 *
 *  @param originImage 原始图片
 *  @param maxSize     最大字节数
 *
 *  @return 压缩后的图片
 */
+ (ZZImageCompressManager *)compressImage:(UIImage *)originImage maxSize:(NSUInteger)maxSize;

@end
