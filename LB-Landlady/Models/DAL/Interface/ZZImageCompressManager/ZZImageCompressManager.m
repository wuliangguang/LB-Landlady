//
//  ZZImageCompressManager.m
//  LB-Landlady
//
//  Created by 刘威振 on 2/29/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZImageCompressManager.h"

@implementation ZZImageCompressManager

/**
 *  压缩图片(默认最大为500k Byte)
 *
 *  @param originImage 原始图片
 *
 *  @return 压缩后的图片
 */
+ (ZZImageCompressManager *)compressImage:(UIImage *)originImage {
    return [self compressImage:originImage maxSize:20*1024];
}

/**
 *  压缩图片
 *
 *  @param originImage 原始图片
 *  @param maxSize     最大字节数
 *
 *  @return 压缩后的图片
 */
+ (ZZImageCompressManager *)compressImage:(UIImage *)originImage maxSize:(NSUInteger)maxSize {
    ZZImageCompressManager *compressImage = nil;
    NSData *imageData                    = UIImageJPEGRepresentation(originImage, 1.0);
    if (imageData.length <= maxSize || maxSize == 0) {
        compressImage       = [[ZZImageCompressManager alloc] init];
        compressImage.image = originImage;
        compressImage.data  = imageData;
        return compressImage;
    } else {
        UIImage *targetImage = [[UIImage alloc] initWithData:imageData];
        CGFloat compress = 1.0;
        while (imageData.length > maxSize && compress > 0) {
            compress = compress - 0.01;
            imageData = UIImageJPEGRepresentation(targetImage, MAX(0.01, compress));
            NSLog(@"压缩中...  %lu", imageData.length);
        }
        
        targetImage         = [[UIImage alloc] initWithData:imageData];
        compressImage       = [[ZZImageCompressManager alloc] init];
        compressImage.image = targetImage;
        compressImage.data  = imageData;
        return compressImage;
    }
}

@end
