//
//  ZZAddImageManagerView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZAddImageManagerView.h"
#import "ZZActionImageView.h"
#import "ZZImageScanViewController.h"
#import <LianBiLib/Base64.h>
#import "UIImageView+WebCache.h"
#import "ZZImageCompressManager.h"
#import "NSObject+Helper.h"
#import "UIImage+Base64.h"

@interface ZZAddImageManagerView ()

@property (nonatomic) NSMutableArray *itemArray;
@property (nonatomic) UILabel *infoLabel;
@property (nonatomic) UIButton *addButton;

// 数组,记录用户操作信息
@property (nonatomic) NSMutableArray *deleteArray;
@property (nonatomic) NSMutableArray *addArray;

@end

@implementation ZZAddImageManagerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (NSMutableArray *)deleteArray {
    if (_deleteArray == nil) {
        _deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

- (NSMutableArray *)addArray {
    if (_addArray == nil) {
        _addArray = [NSMutableArray array];
    }
    return _addArray;
}

- (void)setUp {
    CGRect rect      = CGRectMake(kManagerViewXPadding, kManagerViewYPadding, kManagerViewItemLength, kManagerViewItemLength);
    if (self.addButton == nil) {
        self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"my_merchant_add_image"] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];
    }
    self.addButton.frame = rect;
    
    CGRect frame = CGRectMake(CGRectGetMaxX(self.addButton.frame) + kManagerViewXPadding, CGRectGetMaxY(self.addButton.frame)-kManagerViewXPadding, kManagerViewItemLength, kManagerViewXPadding);
    if (self.infoLabel == nil) {
        self.infoLabel           = [[UILabel alloc] initWithFrame:frame];
        self.infoLabel.textColor = LD_COLOR_TWELVE;
        self.infoLabel.font      = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.infoLabel];
    }
    self.infoLabel.frame = frame;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    self.infoLabel.text = [NSString stringWithFormat:@"最多%ld张", maxCount];
}

- (void)addButtonClick:(UIButton *)button {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

- (void)addImage:(UIImage *)image {
    [self addItem:image];
}

- (void)addImageWithUrl:(NSString *)url {
    [self addItem:url];
}

- (void)addItem:(id)obj {
    if (self.itemArray.count >= self.maxCount) return;
    if (!obj) return;
    ZZActionImageView *imageView = nil;
    if ([obj isKindOfClass:[UIImage class]]) {
        UIImage *addImage = (UIImage *)obj;
        imageView = [[ZZActionImageView alloc] initWithImage:addImage];
        [self.addArray addObject:addImage.base64Str]; // 增加的本地图片,没有关联的url
    } else {
        imageView = [[ZZActionImageView alloc] initWithFrame:CGRectMake(0, 0, kManagerViewItemLength, kManagerViewItemLength)];
        imageView.backgroundColor = [UIColor yellowColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] completed:nil];
        imageView.attachObject = obj; // 增加的网络图片,有关联的url
    }
    
    [self addSubview:imageView];
    [self.itemArray addObject:imageView];
    [imageView addTarget:self forSelector:@selector(imageViewClick:)];
    [self refresh];
}

- (void)imageViewClick:(ZZActionImageView *)imageView {
    ZZImageScanViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([ZZImageScanViewController class]) bundle:nil] instantiateInitialViewController];
    controller.image = imageView.image;
    controller.callbackHandler = ^() {
        if (imageView.attachObject != nil) {
            [self.deleteArray addObject:imageView.attachObject]; // 删除从网络上获取的图片[url_1, url_2]
        }
        [self removeImageView:imageView];
        NSLog(@"%@", self.deleteArray);
    };
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:controller animated:YES completion:nil];
}

- (void)removeImageView:(UIImageView *)imageView {
    [imageView removeFromSuperview];
    [self.itemArray removeObject:imageView];
    [self refresh];
}

- (void)refresh {
    [UIView animateWithDuration:.25 animations:^{
        if (self.itemArray.count > 0) {
            for (NSInteger i = 0; i < self.itemArray.count; i++) {
                ZZActionImageView *imageView = self.itemArray[i];
                imageView.frame = CGRectMake(kManagerViewXPadding+(kManagerViewItemLength+kManagerViewXPadding)*i, kManagerViewYPadding, kManagerViewItemLength, kManagerViewItemLength);
                
                if (i == self.itemArray.count - 1) {
                    if (i >= self.maxCount-1) {
                        self.addButton.hidden = self.infoLabel.hidden = YES;
                        return;
                    } else {
                        self.addButton.hidden = self.infoLabel.hidden = NO;
                        CGRect frame = self.addButton.frame;
                        frame.origin.x = CGRectGetMaxX(imageView.frame) + kManagerViewXPadding;
                        self.addButton.frame = frame;
                        
                        frame = self.infoLabel.frame;
                        frame.origin.x = CGRectGetMaxX(self.addButton.frame) + kManagerViewXPadding;
                        self.infoLabel.frame = frame;
                    }
                }
            }
        } else {
            [self setUp];
        }
    }];
}

- (NSMutableArray *)itemArray {
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

- (NSArray<UIImage *> *)images {
    if (self.itemArray.count <= 0) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.itemArray) {
        UIImage *image = imageView.image;
        if (image == nil) {
            continue;
        }
        [array addObject:imageView.image];
    }
    return array;
}

- (NSString *)imageStrings {
    NSArray *images = [self images];
    if (images.count <= 0) {
        return nil;
    }
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i = 0; i < images.count; i++) {
        UIImage *image = images[i];
        [mArr addObject:image.base64Str];
    }
    return [self getStringWithArray:mArr];
}

/**
 *  删除的图片数组
 */
- (NSArray<UIImage *> *)deleteImages {
    return self.deleteArray;
}

/**
 *  增加的图片所对应的Base64字符串
 */
- (NSString *)addImageStrings {
    return [self getStringWithArray:self.addArray];
}

/**
 *  删除的图片所对应的Base64字符串
 */
- (NSString *)deleteImageStrings {
    return [self getStringWithArray:self.deleteArray];
}

- (NSString *)getStringWithArray:(NSArray *)array {
    /** 自己实现
    NSMutableString *mStr = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < array.count; i++) {
        if (i != array.count - 1) {
            [mStr appendFormat:@"%@,", array[i]];
        } else {
            [mStr appendString:array[i]];
        }
    }
    // NSLog(@"%@", [mArr mj_JSONString]);
    // return [mArr mj_JSONString];
    return mStr;
     */
    
    // API实现
    return array.count <= 0 ? @"" : [array componentsJoinedByString:@","];
}

@end
