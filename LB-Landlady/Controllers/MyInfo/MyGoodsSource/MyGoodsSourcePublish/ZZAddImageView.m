//
//  ZZAddImageView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZAddImageView.h"
#import "ZZImagePickerManager.h"

@interface ZZAddImageView ()


@end

@implementation ZZAddImageView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ZZImagePickerManager pickImageInController:[[[UIApplication sharedApplication] keyWindow] rootViewController] completionHandler:^(UIImage *image) {
        self.imageView.image = image;
        self.imageBuffer = image;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
