//
//  MyMerchantAddressBottomView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
#import "Address.h"

@interface MyMerchantAddressBottomView : UIView

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) block_id_t callbackHandler;
@end
