//
//  WebVC.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController<UIWebViewDelegate>

/**
 *  发布产品WEB URL
 */
@property (nonatomic, strong) NSString *urlString;
@property(nonatomic ,copy)void(^addBlock)();

@end
