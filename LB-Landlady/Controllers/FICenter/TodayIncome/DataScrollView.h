//
//  DataScrollView.h
//  LinkTown
//
//  Created by 喻晓彬 on 15/11/16.
//  Copyright © 2015年 d2space. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    FROM_Month,
    FROM_DayOnline,
    FROM_Finacial,
    FROM_Trade,
}FROM;

@interface DataScrollView : UIView
@property (nonatomic,copy) void(^ChangeDateWhenClickButton)(NSString * selectMonth, NSInteger selectYear);
@property(nonatomic,assign)FROM fromVC;
@end
