//
//  MyMerchantViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/14/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "MyMerchantIntroViewController.h"
#import "MyMerchantListViewController.h"
#import "MyMerchantAddressViewController.h"
#import "MyMerchantChangeNameViewController.h"
#import "MyMerchantChangePhoneViewController.h"
#import "ZZImageScalePickerManager.h" // 图片选择器
#import "MerchantListItemModel.h" // 商铺列表项
#import <LianBiLib/Base64.h>
#import "CommonModel.h"
#import "UIImageView+WebCache.h"
#import <LianBiLib/ImageExtension.h>
#import "MBProgressHUD+ZZConvenience.h"
#import "MerchantInfoManager.h"
#import "RootViewController.h"
#import "MerchantInfoManager.h"
#import "UIImage+Base64.h"
#import "CustomImage.h"
@interface MyMerchantViewController ()

/**
 *  名字
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *locationName;

/**
 *  类型
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

/**
 *  背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;


/**
 *  商铺标志图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;

/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;

/**
 *  联系电话
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

/**
 *  商铺地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MyMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    if (App_User_Info.myInfo.userModel.defaultBusiness) {
        NSLog(@"%@", App_User_Info.myInfo.businessModel);
        [self fetchWebData:App_User_Info.myInfo.userModel.defaultBusiness];
    }
}

/**
 *  获取我的商铺信息
 *
 *  @param busnessId 用户绑定的商户id
 */
- (void)fetchWebData:(NSString *)busId {
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSString *businessId = busId;
    NSArray *rurur = @[
                       @{@"name":@"userId",@"detailStr":userId},
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
    
    NSDictionary *parms = @{@"userId":userId,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};

    [S_R LB_GetWithURLString:[URLService getBusinessInfoUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"-------------------获取我的商铺信息:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MyBusinessInfoModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            MyBusinessInfoModel *businessInfo = (MyBusinessInfoModel *)commonModel.data;
            App_User_Info.myInfo.userModel.defaultBusiness = businessInfo.businessId;
            App_User_Info.myInfo.businessModel = businessInfo;
            [self refreshUI];
        } else {
     
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

- (void)refreshUI {
    MyBusinessInfoModel *businessInfo = App_User_Info.myInfo.businessModel;
    self.nameLabel.text        = businessInfo.businessName;
    self.locationName.text     = businessInfo.address;
    [self.shopIconImageView sd_setImageWithURL:[NSURL URLWithString:businessInfo.logoUrl] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
    self.contactNameLabel.text = businessInfo.contactName;
    self.phoneLabel.text       = businessInfo.mobile;
    self.addressLabel.text     = businessInfo.address;
    
    if (businessInfo.businessImgURL.count <= 0) {
        return;
    }
    __weak __typeof(self)weakself = self;
    BusinessImage *imgUrl = businessInfo.businessImgURL[0];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl.imageUrl] placeholderImage:[UIImage imageNamed:@"Background.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { // 图片模糊化
        if (image != nil) {
            weakself.backImageView.image = [ImageExtension imgBlurEffectWithImage:image];
        }
    }];
}

- (void)initUI {
    self.tableView.sectionFooterHeight = 0;
    UIButton *button = [self addStandardRightButtonWithTitle:@"切换" selector:@selector(changeMerchant)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.title = @"我的商铺";
    
    self.typeLabel.layer.cornerRadius = self.typeLabel.bounds.size.height/2.0;
    self.typeLabel.clipsToBounds      = YES;
    self.typeLabel.backgroundColor    = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
}

/**
 *   进入商铺列表 切换商铺
 */
- (void)changeMerchant {
    MyMerchantListViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
    MyBusinessInfoModel *businessInfo = App_User_Info.myInfo.businessModel;
    if (businessInfo) {
        controller.choosedMerchantItem = [businessInfo convertToMerchantListItemModel];
    } else {
        MerchantListItemModel *choosedItem = [[MerchantListItemModel alloc] init];
        choosedItem.businessId = App_User_Info.myInfo.userModel.defaultBusiness;
        controller.choosedMerchantItem = choosedItem;
    }
    // controller.choosedMerchantItem = App_User_Info.myInfo.businessInfo;
    controller.callbackHandler = ^(id obj) { // 切换店铺成功回调
        [self refreshUI];
        // MyMerchantListViewController *controller = (MyMerchantListViewController *)obj;
        // MerchantListItemModel *item = controller.choosedMerchantItem;
        // [self fetchWebData:item.business_id];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? self.view.bounds.size.width/4.0 : 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.001 : 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
        }
            break;
        case 1: { // 商铺标志
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            __weak __typeof(self) weakself = self;
            [ZZImageScalePickerManager pickImageWithCallback:^(UIImage *image) {
                self.shopIconImageView.image = image;
                [weakself updateBusinesssLogo:[CustomImage compressImage:image maxSize:1024 * 1024]];
            }];
        }
            break;
        case 2: { // 商铺介绍
            MyMerchantIntroViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantIntroViewController class]) bundle:nil] instantiateInitialViewController];
            FMLog(@"%@",[App_User_Info.myInfo.businessModel mj_JSONObject])
            controller.merchantModel = App_User_Info.myInfo.businessModel;
            controller.callbackHandler = ^(id obj) {
                [self.navigationController popViewControllerAnimated:YES];
                [self fetchWebData:App_User_Info.myInfo.userModel.defaultBusiness];
            };
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 3: {
            switch (indexPath.row) {
                case 0: { // 联系人
                    MyMerchantChangeNameViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantChangeNameViewController class]) bundle:nil] instantiateInitialViewController];
                    controller.name = self.contactNameLabel.text;
                    controller.callbackHandler = ^(NSString *str) {
                        self.contactNameLabel.text = str;
                    };
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                case 1: { // 联系电话
                    MyMerchantChangePhoneViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantChangePhoneViewController class]) bundle:nil] instantiateInitialViewController];
                    MyBusinessInfoModel *businessInfo = App_User_Info.myInfo.businessModel;
                    controller.phone = businessInfo.mobile;
                    controller.callbackHandler = ^(NSString *str) {
                        self.phoneLabel.text = str;
                    };
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 4: { // 商铺地址
            MyMerchantAddressViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddressViewController class]) bundle:nil] instantiateInitialViewController];
            controller.modify = YES;
            controller.callbackHandler = ^(id obj) {
                Address *address = (Address *)obj;
                self.locationName.text                      = address.address;
                self.addressLabel.text                      = address.address;
                App_User_Info.myInfo.businessModel.address   = address.address;
                App_User_Info.myInfo.businessModel.latitude  = [address.latitude doubleValue];
                App_User_Info.myInfo.businessModel.longitude = [address.longitude doubleValue];
            };
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        default:
            break;
    }
}

// 上传店铺logo
- (void)updateBusinesssLogo:(UIImage *)image {
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *logoUrl = image.base64Str;
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSArray *rurur = @[
                       @{@"name":@"logoUrl",@"detailStr":logoUrl},
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
    
    NSDictionary *parms = @{@"logoUrl" : logoUrl,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};

    [S_R LB_PostWithURLString:[URLService updateBusinessLogoUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"---------------修改店铺logo:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            [MBProgressHUD showSuccessToast:@"上传商铺标志图片成功" inView:self.view completionHandler:nil];
        } else {
           // [MBProgressHUD showFailToast:commonModel.msg inView:self.view completionHandler:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showFailToast:@"上传商铺标志图片失败" inView:self.view completionHandler:nil];
    } WithController:self];
}

@end



