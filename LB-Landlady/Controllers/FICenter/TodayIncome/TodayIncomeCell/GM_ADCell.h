//
//  GM_ADCell.h
//  MeZoneB_Bate
//
//  Created by 李宝宝 on 15/11/24.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdDataModel.h"

@interface GM_ADCell : UITableViewCell

@property (nonatomic      ) NSArray   *adsDataArr;
@property (nonatomic, copy) NSString  *placeholderImage;
@property (nonatomic      ) NSInteger type;

@property (nonatomic, copy) block_id_t callbackHandler;
@end
