//
//  ScaleImage.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/27.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ScaleImage.h"

@implementation ScaleImage
+(UIImage * )scaleImageWithImage:(UIImage *)image
{
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    UIImage * result = [UIImage imageWithData:data];
    return result;
}
@end
