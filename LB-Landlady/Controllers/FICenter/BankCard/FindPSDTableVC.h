//
//  FindPSDTableVC.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/17.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindPsdCell.h"

@interface FindPSDTableVC : UITableViewController
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,strong)NSString * bankCardNum;
@property(nonatomic,strong)NSNumber * bankCardID;
@property(nonatomic,strong)NSString * code;

@end
