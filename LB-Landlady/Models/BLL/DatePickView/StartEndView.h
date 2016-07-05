//
//  StartEndView.h
//  demo
//
//  Created by 露露 on 16/1/17.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    TIMETYPE_START,
    TIMETYPE_END,
}TIMETYPE;

@interface StartEndView : UIView
@property (strong, nonatomic) IBOutlet UIButton *startTime;
@property (strong, nonatomic) IBOutlet UIButton *endTime;
@property(nonatomic,copy)void (^BtnBlock)(id obj,TIMETYPE type);
@end
