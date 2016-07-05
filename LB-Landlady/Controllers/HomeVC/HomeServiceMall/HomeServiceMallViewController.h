//
//  InfoWebViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeServiceMallViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**
 *  webview url
 */
@property (nonatomic, strong) NSString *urlString;
/**
 *  功能模块类型
 */
@property (nonatomic, strong) NSString *moduleType;

@property(nonatomic,copy)void (^clickBlock)(NSInteger obj);
@end
