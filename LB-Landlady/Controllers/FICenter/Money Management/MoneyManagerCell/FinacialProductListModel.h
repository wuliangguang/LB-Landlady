//
//  FinacialProductListModel.h
//  MeZoneB_Bate
//
//  Created by 露露 on 15/12/16.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinacialProductListModel : NSObject
@property(nonatomic,strong)NSString * create_time;
@property(nonatomic,strong)NSString * descriptiontext;
@property(nonatomic,strong)NSNumber * ID;
@property(nonatomic,strong)NSString * lable;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)float rate;

@end
