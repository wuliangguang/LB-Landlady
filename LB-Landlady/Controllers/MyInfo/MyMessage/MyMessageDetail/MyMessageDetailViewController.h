//
//  MyMessageDetailViewController.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageModel.h"

@interface MyMessageDetailViewController : UIViewController

@property (nonatomic) MyMessageModel *messageModel;
@property (nonatomic, copy) block_id_t callbackHandler;
@end
