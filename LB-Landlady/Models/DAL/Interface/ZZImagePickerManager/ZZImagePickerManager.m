//
//  ZZImagePickerManager.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZImagePickerManager.h"

@interface ZZImagePickerManager () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, assign) UIViewController *controller;
@property (nonatomic, copy) void (^completionHandler)(UIImage *image);
@end

@implementation ZZImagePickerManager

static ZZImagePickerManager *pickerManager = nil;

+ (instancetype)sharedPickeManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pickerManager = [[ZZImagePickerManager alloc] init];
    });
    return pickerManager;
}

+ (void)pickImageInController:(UIViewController *)controller completionHandler:(void (^)(UIImage *image))completionHandler {
    ZZImagePickerManager *pickerManager = [self sharedPickeManager];
    pickerManager.controller            = controller;
    pickerManager.completionHandler     = completionHandler;
    
    [[self sharedPickeManager] setController:controller];
    [controller.view endEditing:YES];
    UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:[self sharedPickeManager] cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [sheet showInView:controller.view];
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self showImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self showImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        default:
            break;
    }
}

// 系统相册取图片或拍照要用UIImagePickerController, 有一个sourceType，这个属性决定是取图片还是拍照
- (void)showImagePickerWithType:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate                 = self;
        imagePicker.allowsEditing            = YES;
        imagePicker.sourceType               = type;
        [self.controller presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error accessing photo library!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@", info);
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        
        // CGSize size = CGSizeMake(ceil(self.iconImageView.frame.size.width), ceil(self.iconImageView.frame.size.height));
        // self.iconImageView.image = [CustomImage imageWithOrigin:editedImage size:size];
        if (self.completionHandler) {
            self.completionHandler(editedImage);
            self.completionHandler = nil;
        }
    }];
}

@end
