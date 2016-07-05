//
//  IncomeOnlineViewController.h
//  MeZoneB_Bate
//
//  Created by d2space on 15/9/21.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum
//{
//    INCOME_ONLINE,
//    INCOME_STORE,
//    INCOME_COMMISSION,
//    INCOME_ADVERTISMENT,
//    INCOME_ROUTER,
//}IncomeType;
typedef enum
{
    INCOME_ONLINE,
    INCOME_STORE,
    INCOME_CHANGECASH,
    INCOME_BANKCARD,
}IncomeType;

@interface IncomeOnlineViewController : UIViewController
@property (nonatomic, assign)IncomeType       incomeType;
@end
