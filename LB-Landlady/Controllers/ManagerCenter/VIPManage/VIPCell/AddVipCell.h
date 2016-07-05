//
//  AddVipCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddVipCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *telNumLab;
@property (strong, nonatomic) IBOutlet UIButton *rejectBtn;
@property (strong, nonatomic) IBOutlet UIButton *OKbtn;
@property(nonatomic,assign)NSInteger associationId;
@property(nonatomic,copy)void(^cellBlock)(NSInteger status , NSInteger associationID);
@end
