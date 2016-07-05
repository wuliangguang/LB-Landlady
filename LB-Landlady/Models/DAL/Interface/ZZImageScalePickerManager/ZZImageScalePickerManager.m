//
//  ZZImageScalePickerManager.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZImageScalePickerManager.h"

@interface ZZImageScalePickerManager ()

@property (nonatomic, copy) void (^callback)(UIImage *image);
@property (nonatomic) VPViewController *vpController;
@end

static ZZImageScalePickerManager *_imageScalePickerManager;

@implementation ZZImageScalePickerManager

+ (void)pickImageWithCallback:(void (^)(UIImage *image))callbackHandler {
    [self pickImageWithScale:CGSizeMake(0, 0) callback:callbackHandler];
}

+ (void)pickImageWithScale:(CGSize)scale callback:(void (^)(UIImage *image))callbackHandler {
    if (_imageScalePickerManager == nil) {
        _imageScalePickerManager = [[ZZImageScalePickerManager alloc] init];
    }
    
    _imageScalePickerManager.callback = callbackHandler;
    
    CGRect frame = CGRectZero;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    frame.size.width = scale.width == 0 ? bounds.size.width : scale.width;
    frame.size.height = scale.height == 0 ? bounds.size.width : scale.height;
    frame.origin.x = CGRectGetMidX(bounds)-frame.size.width/2.0;
    frame.origin.y = CGRectGetMidY(bounds)-frame.size.height/2.0;
    
    _imageScalePickerManager.vpController = [[VPViewController alloc] init];
    _imageScalePickerManager.vpController.cropRect = frame;
    _imageScalePickerManager.vpController.delegate = _imageScalePickerManager;
    [_imageScalePickerManager.vpController editPortrait];
}

#pragma mark - <VPViewControllerDelegate>
- (void)pickImageFinished:(UIImage *)image {
    if (_imageScalePickerManager.callback) {
        _imageScalePickerManager.callback(image);
    }
    _imageScalePickerManager = nil;
}

@end
