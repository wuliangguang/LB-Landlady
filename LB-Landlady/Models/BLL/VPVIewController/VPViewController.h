//
//  VPViewController.h
//  VPImageCropperDemo
//
//  Created by Vinson.D.Warm on 1/13/14.
//  Copyright (c) 2014 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 为了便于封装(ZZImageScalePickerManager)和在iOS8上弹出actionSheet后再弹出UIImagePickerController容易引发一些问题，此三方库已作稍许修改 -- 刘威振 2016-1-23

@protocol VPViewControllerDelegate <NSObject>

-(void)pickImageFinished:(UIImage*)image;

@end

@interface VPViewController : UIViewController{
    CGRect _cropRect;
}

@property (nonatomic, assign) id<VPViewControllerDelegate>delegate;
@property (nonatomic, assign) CGRect cropRect;

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex ;

- (void)editPortrait;
@end
