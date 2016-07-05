//
//  HomeViewController.m
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "HomeViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "DirectivePageViewController.h"
#import "HomeMonyInfoCell.h"
#import "HomeGoodsSupplyCell.h"
#import "HomeGoodsMallCell.h"
#import "HomeServiceMallCell.h"
#import "PowerfulBannerView.h"
#import "HomeGoodsSupplyHeaderView.h"
#import "HomeGoodsMallHeaderView.h"
#import "CustomImage.h"
#import "QRCodeViewController.h"
#import "HomeServiceMallViewController.h"
#import "IncomeTableVC.h"
#import "GoodsSourceDetailVC.h"
#import "MyGoodsSourceShopViewController.h"
#import "InfoWebViewController.h"
#import "UIViewController+Login.h"
#import "NSUserDefaults+Helper.h"
#import "CommonModel.h"
#import "GoodSourceProductDataModel.h"
#import "ServerMallListDataModel.h"
#import <UIImageView+WebCache.h>
#import "MyInfoDataModel.h"
#import "IncomeDataModel.h"
#import "AdDataModel.h"
#import "UIViewController+ZZNavigationItem.h"
#import "UIViewController+ShowWeb.h"
#import "MyMerchantAddViewController.h"
#import "HomePopContentView.h"
#import "OrderListTVC.h"
#import "OrderGenerateVC.h"
#import "ZZShowMessage.h"
#import "OrderDetailVCWithQCode.h"
#import "MyMerchantListViewController.h"
#import "NotificationHelper.h"
#import "OrderQueryViewController.h"
#import "TodayIncomeCell.h"
#import "OrderTheDetailCell.h"
#import "MCQCodeCellTableViewCell.h"
#import <LianBiLib/CustomQrCode.h>
#import "NSDate+Helper.h"
#import <LianBiLib/Base64+Custom.h>
@interface HomeViewController () <BMKLocationServiceDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIImageView * QCodeImageview;/**<点击二维码出来的大的ImageView*/
}
@property (nonatomic, strong) BMKLocationService* locService;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *adArray;
@property(nonatomic,strong) UIView * maskView;
// @property (nonatomic) DXPopover *popover;

/**
 *  服务商城列表Model
 */
@property (nonatomic) ServerMallListDataModel *serviceMallModel;

/**
 *  货源特惠
 */
@property (nonatomic) GoodSourceProductDataModel *productDataModel;

/**
 *  收入
 */
@property (nonatomic) IncomeDataModel *income;
@end

@implementation HomeViewController
#pragma mark ******************************* BMKLocationServiceDelegate *******************************
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    /**
     *  当前经纬度
     */
    NSString * lng = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    NSString * lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    
    //获取经纬度后必须停止定位
    [self.locService stopUserLocationService];
    
    [NSUserDefaults standardUserDefaults].latitude = lat;
    [NSUserDefaults standardUserDefaults].longitude = lng;
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    //停止定位
    [self.locService stopUserLocationService];
}

#pragma mark ****************************** Initialization ******************************
-(void)initBMKLocationView
{
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}
#pragma mark ******************************* Private Method *******************************
-(void)login
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
}
#pragma mark ******************************* VC Life Cycle *******************************


#pragma mark ------ButtonClick------

-(void)tapGesture:(UITapGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.5 animations:^{
        [_maskView removeFromSuperview];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    
//        if ([[NSUserDefaults standardUserDefaults] didAccess] == NO) {
//            [self performSelectorOnMainThread:@selector(gotoDirectivePage) withObject:nil waitUntilDone:NO]; // 不阻塞主线程
//        }
//
//    });
    /**
     *百度地图
     */
    [self initBMKLocationView];
    
    [self initUI];

    // 服务商城 和登录无关
   // [self getServiceMallList];
    
    // 和商铺信息相关
    [self handleMerchantInfo:MerchantInfoStatusUnknown];
    
    // 广告，和登录无关
    // [self performSelector:@selector(getAdvertisement) withObject:nil afterDelay:5]; // 服务器待修改，串行请求
    [self getAdvertisement];
  //  [self getProductSourcepReference];
    
    // 经营总收入改变，注册通知
    [NotificationHelper registNotificationOfIncomeChangeWithObserser:self selector:@selector(incomeDidChange:)];
    
    // 和登录相关接口
    [self handleLogin:LoginStatusUnknown];
}

// 经营总收入发生变化
- (void)incomeDidChange:(NSNotification *)notification {
    [self getCountByBusiness];
    [self getDayCount];
}

- (void)getAdvertisement {
    [S_R LB_GetWithURLString:[URLService getAdvertismentURL] WithParams:@{@"type" : s_ad_home} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"-----------------广告:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[AdDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            AdDataModel *dataModel = commonModel.data;
            self.adArray = dataModel.advertList;
            if (self.adArray) {
                [self.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

// 进引导页
- (void)gotoDirectivePage {
    // 进入引导页
    DirectivePageViewController *directController = [[DirectivePageViewController alloc] init];
    __weak __typeof(directController)weakDirectController = directController;
    directController.endCallback = ^{
        [weakDirectController dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:directController animated:NO completion:nil];
}

/**
 *  获取货源特惠信息
 */
//- (void)getProductSourcepReference {//货源特惠
//    NSString *userId     = App_User_Info.myInfo.user.user_id > 0 ? App_User_Info.myInfo.user.user_id : @"";
//    NSString *businessId = App_User_Info.myInfo.user.business_bound.length > 0 ? App_User_Info.myInfo.user.business_bound : @"";
//    NSString *industryId = App_User_Info.myInfo.businessInfo.industry_id.length > 0 ? App_User_Info.myInfo.businessInfo.industry_id : @"";
//    [S_R LB_GetWithURLString:[URLService getProductSourcepReferenceUrl] WithParams:@{@"userId" : userId, @"businessId" : businessId, @"industryId" : industryId} WithSuccess:^(id responseObject, id responseString) {
//        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[GoodSourceProductDataModel class]];
//        if (commonModel.code == SUCCESS_CODE) {
//            GoodSourceProductDataModel *dataModel = (GoodSourceProductDataModel *)commonModel.data;
//            NSIndexPath *indexPath                = [NSIndexPath indexPathForRow:0 inSection:1];
//            HomeGoodsSupplyCell *cell             = [self.tableView cellForRowAtIndexPath:indexPath];
//            cell.productDataModel                 = dataModel;
//        }
//    } failure:^(NSError *error) {
//    } WithController:self];
//}

- (void)initUI {
    // right bar button item
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"my_more"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // table view
    CGRect frame              = self.view.bounds;
    frame.size.height        -= self.navigationController.navigationBar.frame.size.height+44;
    self.tableView            = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    //self.tableView.bounces = NO;
    // regist cell
    [self registCell:[HomeMonyInfoCell class]];
    [self registCell:[TodayIncomeCell class]];
    [self registCell:[OrderTheDetailCell class]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MCQCodeCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"code"];
    [self.view addSubview:self.tableView];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 header ");
        if (App_User_Info.haveLogIn) {
            
            if (App_User_Info.myInfo.userModel.defaultBusiness.length <= 0) {
                [self.tableView.header endRefreshing];
               // NSLog(@"------------------------------------App_User_Info.myInfo.user.business_bound.length:%ld",App_User_Info.myInfo.user.business_bound.length);
                // 新增商铺
                MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
                __weak __typeof(self) weakself = self;
                controller.callbackHandler = ^(id obj) {
                    __strong __typeof(weakself) strongSelf = weakself;
                    [self.navigationController popViewControllerAnimated:NO];
                    // 进入店铺列表
                    MyMerchantListViewController *listController = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
                    listController.callbackHandler = ^(id obj) {
                        NSLog(@"%@", obj);
                    };
                    [strongSelf.navigationController pushViewController:listController animated:YES];
                };
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }else{
                //NSLog(@"------+++++++++------------------------------App_User_Info.myInfo.user.business_bound.length:%ld",App_User_Info.myInfo.user.business_bound.length);
                [self getCountByBusiness];
                [self getDayCount];
            }
            
        }else{
            [self.tableView.header endRefreshing];
            [self loginWithInfoType:s_web_type_sweep callback:^(id model) {}];
            
        }
    }];
    
}

- (void)more:(UIButton *)button {
    /**
     * 如果没有登录，去功能介绍，登录
     * 如果没有店铺，去铺定店铺
     * 如果有登录，也有店铺，弹框
     */
    if (App_User_Info.haveLogIn == NO) {
        [self loginWithInfoType:s_web_type_sweep callback:^(id model) {}];
        return;
    }
    if (App_User_Info.myInfo.userModel.defaultBusiness.length <= 0) {
        // 新增商铺
        MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
        controller.hidesBottomBarWhenPushed = YES;
        __weak __typeof(self) weakself = self;
        controller.callbackHandler = ^(id obj) {
            // 进入店铺列表
            __strong __typeof(weakself) strongSelf = weakself;
            [self.navigationController popViewControllerAnimated:NO];
            // 进入店铺列表
            MyMerchantListViewController *listController = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
            listController.callbackHandler = ^(id obj) {
                NSLog(@"%@", obj);
            };
            [strongSelf.navigationController pushViewController:listController animated:YES];
        };
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    // 需求修改：直接去订单生成
    OrderGenerateVC *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([OrderGenerateVC class]) bundle:nil] instantiateInitialViewController];
    UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nivController animated:YES completion:nil];
    
    /**
    // 弹框
    self.popover = [[DXPopover alloc] init];
    self.popover.backgroundColor = ColorA(0, 0, 0, 0.5);
    HomePopContentView *popContentView = [HomePopContentView homePopContentView];
    __weak __typeof(self) weakself = self;
    
    popContentView.orderListHandler = ^() { // 订单列表
        NSLog(@"进入订单列表");
        OrderListTVC * order = [[OrderListTVC alloc]init];
        order.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:order animated:YES];
        [weakself.popover dismiss];
    };
    
    popContentView.orderGenerateHandler = ^() { // 订单生成
        OrderGenerateVC *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([OrderGenerateVC class]) bundle:nil] instantiateInitialViewController];
        UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nivController animated:YES completion:nil];
        [weakself.popover dismiss];
    };
    [self.popover showAtPoint:CGPointMake(button.center.x+5, 50) popoverPostion:DXPopoverPositionDown withContentView:popContentView inView:[[UIApplication sharedApplication] keyWindow]];
     */
}

- (void)registCell:(Class)cls {
    NSString *str = NSStringFromClass(cls);
    [self.tableView registerNib:[UINib nibWithNibName:str bundle:nil] forCellReuseIdentifier:str];
}

- (void)registHeaderView:(Class)cls {
    NSString *str = NSStringFromClass(cls);
    [self.tableView registerNib:[UINib nibWithNibName:str bundle:nil] forHeaderFooterViewReuseIdentifier:str];
}
- (void)registTableViewCell:(Class)cls{
    NSString *str = NSStringFromClass(cls);
    [self.tableView registerClass:cls forCellReuseIdentifier:str];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _locService.delegate = nil;
    _locService = nil;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: { // 总收入
            switch (indexPath.row) {
                case 0:
                {
                    HomeMonyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeMonyInfoCell class]) forIndexPath:indexPath];
                    cell.income = self.income;
                    return cell;
                }
                    break;
                   case 1:
                {
                    TodayIncomeCell *today = [tableView dequeueReusableCellWithIdentifier:@"TodayIncomeCell"];
                    
                    return today;
                }
                    break;
                    case 2:
                {
                    OrderTheDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTheDetailCell"];
                    cell.block = ^(id obj){
                        if (App_User_Info.haveLogIn) {
                            if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0) {
                                NSString *string = (NSString *)obj;
                                OrderQueryViewController *order = [[OrderQueryViewController alloc]init];
                                order.string= string;
                                if ([string isEqualToString:@"orderDetailButtonClock"]) {
                                    order.titleStr = @"订单明细";
                                }else if ([string isEqualToString:@"incomeDetailButtonClock"]){
                                    order.titleStr = @"收入明细";
                                }
                                order.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:order animated:YES];
                            }else
                            {
                                MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
                                controller.hidesBottomBarWhenPushed = YES;
                                __weak __typeof(self) weakself = self;
                                controller.callbackHandler = ^(id obj) {
                                    __strong __typeof(weakself) strongSelf = weakself;
                                    [self.navigationController popViewControllerAnimated:NO];
                                    
                                    // 进入店铺列表
                                    MyMerchantListViewController *listController = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
                                    listController.callbackHandler = ^(id obj) {
                                        NSLog(@"%@", obj);
                                    };
                                    [strongSelf.navigationController pushViewController:listController animated:YES];
                                };
                                [self.navigationController pushViewController:controller animated:YES];
                            }
                        }else
                        {
                            NSString *str = (NSString *)obj;
                            if ([str isEqualToString:@"orderDetailButtonClock"]) {
                                [self loginWithInfoType:@"orderdetail" callback:^(id model) {}];
                            }else if ([str isEqualToString:@"incomeDetailButtonClock"]){
                                [self loginWithInfoType:@"incomedetail" callback:^(id model) {}];
                            }
                            
                        }
                        
                    };
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
                    break;
        case 1:{
        
       
            MCQCodeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"code"];
            cell.merchantItem = [App_User_Info.myInfo.businessModel convertToMerchantListItemModel];
            /**
             *  点击二维码Button的回调事件（弹出大的二维码view动画）
             */
            cell.QCodeBtnClickBlock=^{
                if (App_User_Info.myInfo.userModel.defaultBusiness.length <= 0) {
                    return ;
                }
                _maskView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
                _maskView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
                UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
                [_maskView addGestureRecognizer:recognizer];
                
                QCodeImageview = [[UIImageView alloc] init];
                QCodeImageview.backgroundColor = [UIColor whiteColor];
                QCodeImageview.bounds = CGRectMake(0, 0, kScreenWidth-80, kScreenWidth-80);
                QCodeImageview.center =  _maskView.center;
                // QCodeImageview.image = [UIImage imageNamed: @"QCode"];
                NSString *businessId = App_User_Info.myInfo.businessModel.businessId;
                NSString *businessName = App_User_Info.myInfo.businessModel.businessName;
                NSString *newBusinessName = [businessName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *qrContent = [NSString stringWithFormat:@"%@%@%@%@%@",s_backOffPath,s_centerPath,businessId,s_wecchatPath,newBusinessName];
                NSLog(@"%@",qrContent);
                QCodeImageview.image = [CustomQrCode createQRCodeWithValue:qrContent WithRed:0 Green:0 Blue:0 WithSize:QCodeImageview.bounds.size.width];
                [_maskView addSubview:QCodeImageview];
                [self.view.window addSubview:_maskView];
                
                BOOL _isiOS7 = ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending);
                _maskView.transform = CGAffineTransformMakeScale(0.0, 0.0);
                if (_isiOS7) {
                    [UIView animateWithDuration:0.5 delay:0
                         usingSpringWithDamping:0.7
                          initialSpringVelocity:3
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                                         _maskView.transform = CGAffineTransformIdentity;
                                     }
                                     completion:nil];
                } else {
                    [UIView animateWithDuration:0.5
                                          delay:0
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                                         _maskView.transform = CGAffineTransformIdentity;
                                     }
                                     completion:nil];
                }
                
            };
            
            /**
             *  点击查看店铺详情的Block回调
             */
            cell.CheckStoreDetailBlock = ^{
                FMLog(@"点击了查看店铺详情");
                if (App_User_Info.haveLogIn ) {
                    if (App_User_Info.myInfo.userModel.defaultBusiness.length !=0) {
                        [self changeMerchant]; // 有店铺，查看详情
                    } else { //没有店铺去绑定
                        MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
                        __weak __typeof(self) weakself = self;
                        controller.callbackHandler = ^(id obj) {
                            __strong __typeof(weakself) strongSelf = weakself;
                            [self.navigationController popViewControllerAnimated:NO];
                            // 进入店铺列表
                            MyMerchantListViewController *listController = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
                            listController.callbackHandler = ^(id obj) {
                                NSLog(@"%@", obj);
                            };
                            [strongSelf.navigationController pushViewController:listController animated:YES];
                        };
                        controller.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:controller animated:YES];
                    }
                } else {
                    //去登录
                    [self loginWithInfoType:@"shops" callback:nil];
                }
            };
            return cell;
            }
                break;
            default:
                break;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)changeMerchant {
    MyMerchantListViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
    controller.choosedMerchantItem = [App_User_Info.myInfo.businessModel convertToMerchantListItemModel];
    controller.callbackHandler = ^(id obj) { // 切换店铺成功回调
        MyMerchantListViewController *controller = (MyMerchantListViewController *)obj;
        MCQCodeCellTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.merchantItem = controller.choosedMerchantItem;
        [self.navigationController popViewControllerAnimated:YES];
        // [self fetchWebData:item.business_id];
    };
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 95;
                    break;
                    case 1:
                    return 88;
                    case 2:
                    return 100;
                    break;
                default:
                    break;
            }
            
            break;
        case 1:
            return 100;
            break;

        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return kScreenWidth/4.0;
            break;
        case 1:
            return 5;
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            PowerfulBannerView *bannerView = [[PowerfulBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4)];
            UIPageControl *pageControl     = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height-15, kScreenWidth, 15)];
            pageControl.numberOfPages      = self.adArray.count;
            bannerView.pageControl         = pageControl;
            bannerView.autoLooping         = YES;
            if (self.adArray.count <= 0) {
                AdModel *model = [[AdModel alloc] init];
                bannerView.items = @[model,model];
            } else {
                bannerView.items = self.adArray;
            }
            [bannerView addSubview:pageControl];
            bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
                UIImageView *imageView = (UIImageView *)reusableView;
                if (!imageView) {
                    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
                    imageView.clipsToBounds = YES;
                }
                AdModel *adModel = (AdModel *)item;
                [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.image] placeholderImage:[UIImage imageNamed:@"banner_4_1"]];
                return imageView;
            };
            bannerView.bannerDidSelectBlock = ^(PowerfulBannerView *banner, NSInteger index){
                
                if (_adArray.count > 0) {
                    AdModel *adModel = self.adArray[index];
                    [self showWebWithTitle:adModel.name url:adModel.url];
                }
                NSLog(@"---------%ld",index);
            };
            return bannerView;
        }
            break;
            case 1:
            return nil;
            break;
        default:
            break;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - navigation item actions
// 定位
- (IBAction)location:(id)sender {
    NSLog(@"TODO:// 定位");
    [self initBMKLocationView];
}

// 获取经营总收入
- (void)getCountByBusiness {
    //NSLog(@"%@", App_User_Info.myInfo.user.business_bound);
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSString *queryType = @"total";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",businessId,queryType,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"businessId":businessId,@"queryType":queryType,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService getCountByBusiness] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
       NSLog(@"---------------total:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        self.income = commonModel.data;
        if (commonModel.code == SUCCESS_CODE) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [self.tableView.header endRefreshing];
    } WithController:self];
}
/**
 *  获取今日收入
 */
- (void)getDayCount {
    //NSString *dateStr = [[NSDate date] toString];
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSString *queryType = @"today";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",businessId,queryType,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"businessId":businessId,@"queryType":queryType,@"sign":sign};
    //NSLog(@"url:%@   parms:%@",[URLService getCountByDay],parms);
    [S_R LB_PostWithURLString:[URLService getCountByDay] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"---------------today:%@",responseObject);
        NSDictionary *data = ((NSDictionary *)responseObject)[@"data"];
        NSString *today = data[@"totalAmt"];
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        
        if (commonModel.code == SUCCESS_CODE) {
            //IncomeDataModel *income  = (IncomeDataModel *)commonModel.data;
             //NSLog(@"income.count:%@", income.count);
            TodayIncomeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell updateWithString:[NSString stringWithFormat:@"%.2f",[today floatValue]/100]];
        }
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.header endRefreshing];
    } WithController:self];
}

#pragma mark - <LoginManagerProtocol>
- (void)handleLogin:(LoginStatus)status {
    switch (status) {
        case LoginStatusUnknown: {
            if (App_User_Info.haveLogIn) {
                [self handleLogin:LoginStatusSuccess];
            } else {
                [self handleLogin:LoginStatusFail];
            }
            break;
        }
        case LoginStatusSuccess: {
            //NSLog(@"-------------------App_User_Info.myInfo:%@",App_User_Info.myInfo.user);
            if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0) {
                [self getCountByBusiness];
                [self getDayCount];
                MCQCodeCellTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                cell.merchantItem = [App_User_Info.myInfo.businessModel convertToMerchantListItemModel];
            }
            break;
        }
        case LoginStatusFail: {
            break;
        }
        case LogoutStatusSuccess: { // 退出登录成功
            [self clean];
            break;
        }
        case LogoutStatusFail: {
            break;
        }
        default:
            break;
    }
}

#pragma mark - <MerchantInfoManagerProtocol>
- (void)handleMerchantInfo:(MerchantInfoStatus)status {
    switch (status) {
        case MerchantInfoStatusUnknown: {
            if (App_User_Info.myInfo.userModel.defaultBusiness.length > 0) {
                [self handleMerchantInfo:MerchantInfoStatusSuccess];
            } else {
                [self handleMerchantInfo:MerchantInfoStatusFail];
            }
            break;
        }
        case MerchantInfoStatusSuccess: {
             [self getCountByBusiness];
             [self getDayCount];
             [self getAdvertisement];
            break;
        }
        case MerchantInfoStatusFail: {
            break;
        }
        default:
            break;
    }
}

// 退出登录成功，清空数据，清空UI
- (void)clean {
    self.income.totalAmt = @"0";
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    TodayIncomeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell updateWithString:@"0"];
    MCQCodeCellTableViewCell *mccell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    mccell.StoreAddressLab.text = @"";
    mccell.StoreNameLab.text = @"";
}

- (void)dealloc {
    [NotificationHelper removeNotificationOfIncomeChangeWithObserver:self object:nil];
}

@end



