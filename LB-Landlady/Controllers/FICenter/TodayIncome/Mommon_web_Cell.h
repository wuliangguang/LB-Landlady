//
//  Mommon_web_Cell.h
//  MeZoneB_Bate
//
//  Created by ios on 15/11/20.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDataModel.h"

/**<chartWebCell */

@interface Mommon_web_Cell : UITableViewCell
@property(nonatomic,assign)int tip;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSArray *xData;/**<x轴坐标*/

//line
@property(nonatomic,strong)NSString * xName;
@property(nonatomic,strong)NSString * yName;
@property(nonatomic,strong)NSString * lineColor;
@property(nonatomic,strong)NSString * bgColor;
@property(nonatomic,strong)NSString * clickName;
@property(nonatomic,strong)NSArray * yArray;/**<每点的y值*/

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *onLineLab;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *storeLab;

@end
