//
//  ZZAddImageManagerView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kManagerViewItemLength 60
#define kManagerViewRowCount 4
#define kManagerViewXPadding (self.bounds.size.width - kManagerViewItemLength*(kManagerViewRowCount+1)) / (kManagerViewRowCount + 1)
#define kManagerViewYPadding 10

/**
 *  TODO:// 封装增加图片的视图，由于时间关系，暂且简单封装，待完善
 */
@interface ZZAddImageManagerView : UIView
@property (nonatomic) NSInteger maxCount;
@property (nonatomic, copy) dispatch_block_t callbackHandler;

- (void)addImage:(UIImage *)image;
- (void)addImageWithUrl:(NSString *)url;

/**
 *  所有的图片数组
 */
- (NSArray<UIImage *> *)images;

/**
 *  所有的图片所对应的Base64字符串
 */
- (NSString *)imageStrings;

/**
 *  删除的图片数组
 */
- (NSArray<UIImage *> *)deleteImages;

/**
 *  增加的图片所对应的Base64字符串
 */
- (NSString *)addImageStrings;

/**
 *  删除的图片所对应的Base64字符串
 */
- (NSString *)deleteImageStrings;

@end
