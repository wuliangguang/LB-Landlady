//
//  UIImage+Base64.m
//  LB-Landlady
//
//  Created by 刘威振 on 3/9/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "UIImage+Base64.h"
#import "NSObject+Helper.h"
#import <LianBiLib/Base64.h>

@implementation UIImage (Base64)

- (void)setBase64Str:(NSString *)base64Str {
    objc_setAssociatedObject(self, @selector(base64Str), base64Str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)base64Str {
    NSString *str = objc_getAssociatedObject(self, _cmd);
    if (str.length <= 0) {
        NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
        str = [Base64 stringByEncodingData:imageData];
        [self setBase64Str:str];
    }
    return str;
}



@end
