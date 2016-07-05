//
//  ItemTitleButton.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  需求：封装上面图片，下面文字，可点击的视图
 */
@interface ItemTitleButton : UIControl

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
