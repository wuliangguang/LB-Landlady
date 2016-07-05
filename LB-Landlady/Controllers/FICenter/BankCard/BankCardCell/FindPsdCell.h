//
//  FindPsdCell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/17.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PSDCallBack)(NSString * psd);

@interface FindPsdCell : UITableViewCell//<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *tilteLab;
@property (strong, nonatomic) IBOutlet UITextField *TF1;
@property (strong, nonatomic) IBOutlet UITextField *TF2;
@property (strong, nonatomic) IBOutlet UITextField *TF3;
@property (strong, nonatomic) IBOutlet UITextField *TF4;
@property (strong, nonatomic) IBOutlet UITextField *TF5;
@property (strong, nonatomic) IBOutlet UITextField *TF6;

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UITextField *topTextField;

@property(nonatomic,copy)PSDCallBack psd;

@end
