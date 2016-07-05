//
//  TableViewMainHeader.h
//  MeZoneB_Bate
//
//  Created by d2space on 15/9/21.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewMainHeader : UIView
@property (weak, nonatomic) IBOutlet UITextField *noticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic, copy) void(^clickMoreBtn)(UIButton *btn);
@end
