//
//  MySourcePublicCategoryView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryModel.h"

@interface MySourcePublicCategoryView : UIView

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, copy) dispatch_block_t callbackHandler;

@property (nonatomic) IndustryModel *model;
@end
