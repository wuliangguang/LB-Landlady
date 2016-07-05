//
//  BindResultViewController.h
//  MeZoneB_Bate
//
//  Created by ios on 15/10/27.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindResultViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *resultImageView;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UILabel *switchLabel;
@property (nonatomic ,strong) NSNumber * resultType;

@end
