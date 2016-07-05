//
//  ZZImageScanViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  封装图片浏览，由于时间关系，暂且如此，待完善
 */
@interface ZZImageScanViewController : UIViewController

@property (nonatomic) UIImage *image;
@property (nonatomic, copy) dispatch_block_t callbackHandler;

@end
