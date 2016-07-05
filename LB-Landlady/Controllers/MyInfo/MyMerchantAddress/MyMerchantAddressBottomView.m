//
//  MyMerchantAddressBottomView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantAddressBottomView.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MBProgressHUD+ZZConvenience.h"

@interface MyMerchantAddressBottomView () <BMKGeoCodeSearchDelegate>

@property (strong, nonatomic) IBOutlet UIView *coordinateView;
@property (strong, nonatomic) IBOutlet UIView *locationView;

@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (strong, nonatomic) BMKGeoCodeSearch *search;

@property (strong, nonatomic) IBOutlet UITextField *addressTextField;

@property (nonatomic) Address *address;
@end

@implementation MyMerchantAddressBottomView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.coordinateView.layer.borderColor = self.locationView.layer.borderColor = LD_COLOR_ELEVEN.CGColor;
    self.coordinateView.layer.borderWidth = self.locationView.layer.borderWidth = 1.0f;
    
    // self.longitudeLabel.text = @"经度test";
    // self.latitudeLabel.text  = @"纬度test";
}

- (IBAction)confirmButtonClick:(UIButton *)button {
    if ([self verifyInputData]) {
        if (self.callbackHandler) {
            self.callbackHandler(self.address);
        }
    }
}

- (BOOL)verifyInputData {
    NSString *address = self.addressTextField.text;
    if (address.length <= 0) {
        [MBProgressHUD showFailToast:@"地址不能为空" inView:self completionHandler:nil];
        return NO;
    }
    NSString *longitude = self.longitudeLabel.text;
    if (longitude.length <= 0) {
        self.longitudeLabel.text = @"0.00";
    }
    NSString *latitude = self.latitudeLabel.text;
    if (latitude.length <= 0) {
        self.latitudeLabel.text = @"0.00";
    }
    self.address           = [[Address alloc] init];
    self.address.longitude = self.longitudeLabel.text;
    self.address.latitude  = self.latitudeLabel.text;
    self.address.address   = address;
    return YES;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate {
    if (_coordinate.latitude != coordinate.latitude || _coordinate.longitude != coordinate.longitude) {
        _coordinate = coordinate;
        self.search = [[BMKGeoCodeSearch alloc] init];
        self.search.delegate = self;
        BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
        option.reverseGeoPoint = _coordinate;
        [self.search reverseGeoCode:option];
        
        self.longitudeLabel.text = [NSString stringWithFormat:@"%lf", coordinate.longitude];
        self.latitudeLabel.text = [NSString stringWithFormat:@"%lf", coordinate.latitude];
    }
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        self.addressTextField.text = result.address;
        // 判断是否为中文
        /**
        for(int i=0; i< [result.addressDetail.city length];i++) {
            int a = [result.addressDetail.city characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff) {
                // App_User_Info.city = result.addressDetail.city;
            }
        }
        for(int i=0; i< [result.addressDetail.district length];i++) {
            int a = [result.addressDetail.district characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff) {
                // App_User_Info.district = result.addressDetail.district;
            }
        }
         */
        // App_User_Info.city = result.addressDetail.city;
        // App_User_Info.district = result.addressDetail.district;
    }
}

@end





