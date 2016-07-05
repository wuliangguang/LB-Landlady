//
//  FICenterViewController.h
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManager.h"
#import "MerchantInfoManager.h"

@interface FICenterViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, LoginManagerProtocol, MerchantInfoManagerProtocol>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end
