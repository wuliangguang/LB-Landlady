//
//  ADCCell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdModel.h"

@interface ADCCell : UICollectionViewCell

@property(nonatomic) NSArray *adsDataArr;
@property(nonatomic,assign)NSInteger type;

@property (nonatomic, copy) block_id_t callbackHandler;
@end
