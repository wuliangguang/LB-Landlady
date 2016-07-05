//
//  MyMerchantAddressViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantAddressViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "UIViewController+ZZNavigationItem.h"
#import "MyMerchantAddressBottomView.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface MyMerchantAddressViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic) BMKMapView *mapView;
@property (nonatomic) BMKLocationService *locationService;
@property (nonatomic) BMKPointAnnotation *currentAnnotation;

@property (weak, nonatomic) IBOutlet MyMerchantAddressBottomView *bottomView;
@end

@implementation MyMerchantAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initUI];
}

- (void)initUI {
    self.title                = @"商铺地址";
    self.view.backgroundColor = [UIColor whiteColor];
    [self startLocation];
    __weak __typeof(self) weakself = self;
    self.bottomView.callbackHandler = ^(Address *address) {
        if (self.modify) { // 对原商铺地址的修改
            NSDictionary *dict = [self returnToModifyTheParametersOfTheShopAddress:address];
            [S_R LB_PostWithURLString:[URLService updateBusinessLogoUrl] WithParams:dict WithSuccess:^(id responseObject, id responseString) {
                NSLog(@"----------------------------修改商铺地址:%@",responseString);
                CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
                if (commonModel.code == SUCCESS_CODE) {
                    if (weakself.callbackHandler) {
                        weakself.callbackHandler(address);
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } else {
                    [MBProgressHUD showFailToast:commonModel.msg inView:self.view completionHandler:nil];
                }
            } failure:^(NSError *error) {
            } WithController:self];
        } else { // 新增的商铺地址
            if (weakself.callbackHandler) {
                weakself.callbackHandler(address);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
}
- (NSDictionary *)returnToModifyTheParametersOfTheShopAddress:(Address *)addre{
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *address = addre.address;
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSArray *rurur = @[
                       @{@"name":@"address",@"detailStr":address},
                       @{@"name":@"businessId",@"detailStr":businessId},
                       @{@"name":@"source",@"detailStr":source},
                       @{@"name":@"serNum",@"detailStr":serNum},
                       @{@"name":@"reqTime",@"detailStr":reqTime}
                       ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in rurur) {
        SendRequestModel *model = [[SendRequestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    NSString *sign = [SendRequestModel backStrFromeArr:dataArray];
    
    NSDictionary *parms = @{@"address" : address,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    return parms;

}
- (void)startLocation {
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    self.locationService          = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    
    self.currentAnnotation        = [[BMKPointAnnotation alloc] init];
    [self.locationService startUserLocationService];
}

#pragma mark - <BMKMapViewDelegate>
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.locationService stopUserLocationService];
    
    if (self.mapView) {
        [self.mapView removeFromSuperview], self.mapView = nil;
    }
    self.mapView                   = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate          = self;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    CLLocationCoordinate2D coor;
    coor.latitude                     = userLocation.location.coordinate.latitude;
    coor.longitude                    = userLocation.location.coordinate.longitude;
    self.currentAnnotation.coordinate = coor;

    /**
    if (App_User_Info.currentCoordinate.longitude > 50.0 && App_User_Info.currentCoordinate.latitude > 10.0) {
        _Pointannotation.coordinate = App_User_Info.currentCoordinate;
    }*/
    
    [self refreshCurrentLocation];
}

// 点击地图
-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"%lf %lf", coordinate.longitude, coordinate.latitude);
    self.currentAnnotation.coordinate = coordinate;
    self.currentAnnotation.title      = @"店铺位置";
    self.currentAnnotation.subtitle   = @"标注此地点";
    [self refreshCurrentLocation];
}

- (void)refreshCurrentLocation {
    BMKCoordinateRegion region = BMKCoordinateRegionMake(self.currentAnnotation.coordinate, BMKCoordinateSpanMake(0.005, 0.005));//越小地图显示越详细
    [self.mapView setRegion:region];
    [self.mapView removeAnnotation:self.currentAnnotation];
    [self.mapView addAnnotation:self.currentAnnotation];
    self.bottomView.coordinate = self.currentAnnotation.coordinate;
    // [self.mapView selectAnnotation:self.currentAnnotation animated:YES];
}

/**
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    //判断是否为中文
    for(int i=0; i< [result.addressDetail.city length];i++)
    {
        int a = [result.addressDetail.city characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            App_User_Info.city = result.addressDetail.city;
        }
    }
    for(int i=0; i< [result.addressDetail.district length];i++)
    {
        int a = [result.addressDetail.district characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            App_User_Info.district = result.addressDetail.district;
        }
    }
    App_User_Info.city = result.addressDetail.city;
    App_User_Info.district = result.addressDetail.district;
    self.navigationItem.hidesBackButton = NO;
}
*/

@end
