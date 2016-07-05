//
//  ViewForGL.h
//  LB-Landlady
//
//  Created by 露露 on 16/3/1.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewForGL : UIView
@property (strong, nonatomic) IBOutlet UIImageView *iconImageview;

@property (strong, nonatomic) IBOutlet UILabel *titleLAB;
@property (strong, nonatomic) IBOutlet UILabel *detailLAB;
@property(nonatomic,copy)void(^buttonClickBlock)(NSInteger index);
- (IBAction)buttonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *bgBTN;

@end
