//
//  ZZImagePickerManager.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  封装图片拾取器，使用系统UIImagePickerController, 不作局部选择(若要对图片进行尺寸)，不做多张图片选择，仅使用系统控件选择一张图片
 */
@interface ZZImagePickerManager : NSObject

+ (void)pickImageInController:(UIViewController *)controller completionHandler:(void (^)(UIImage *image))completionHandler;

@end
