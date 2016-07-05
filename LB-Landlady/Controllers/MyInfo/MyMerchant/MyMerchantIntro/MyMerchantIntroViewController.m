//
//  MyMerchantIntroViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantIntroViewController.h"
#import "SZTextView.h"
#import "ZZActionButton.h"
#import "LimitInput.h"
#import "ZZAddImageManagerView.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "CommonModel.h"

// ----------------------------------------------------------------------------------------------

@interface MyMerchantIntroViewController () <VPViewControllerDelegate>
@property (nonatomic) UIScrollView *scrollView;

/* 增加图片视图 */
@property (nonatomic) ZZAddImageManagerView *managerView;

/* 商铺简介 */
@property (nonatomic) SZTextView *infoTextView;

/* 商铺详细介绍 */
@property (nonatomic) SZTextView *detailInfoTextView;
@end

@implementation MyMerchantIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)setMerchantModel:(MyBusinessInfoModel *)merchantModel {
    if (_merchantModel != merchantModel) {
        _merchantModel = merchantModel;
        _merchantModel.introduce = [_merchantModel.introduce removeWhiteSpacesFromString];
        _merchantModel.details = [_merchantModel.details removeWhiteSpacesFromString];
    }
}

- (void)initUI {
    self.title = @"商铺介绍";
    
    /* UIScrollView */
    CGFloat width = self.view.bounds.size.width;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, kScreenHeight-44)];
    [self.view addSubview:self.scrollView];
    
    /* 增加图片视图 */
    self.managerView             = [[ZZAddImageManagerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    _managerView.maxCount        = 3;
    _managerView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakself = self;
    
    for (NSInteger i = 0; i < MIN(self.merchantModel.businessImgURL.count, 3); i++) {
        BusinessImage *imageUrrObj = self.merchantModel.businessImgURL[i];
        [_managerView addImageWithUrl:imageUrrObj.imageUrl];
    }
    
    _managerView.callbackHandler = ^() {
        weakself.cropRect = CGRectMake(0, kScreenHeight/2-kScreenWidth/2, kScreenWidth, kScreenWidth);
        [weakself editPortrait];
        weakself.delegate = weakself;
    };
    [self.scrollView addSubview:_managerView];
    
    /* 商铺简介 */
    CGFloat padding = 10.0;
    self.infoTextView = [[SZTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_managerView.frame)+padding, width, kManagerViewItemLength+2*kManagerViewYPadding)];
    self.infoTextView.placeholder = @"商铺简介 (50字以内)";
    self.infoTextView.text = self.merchantModel.introduce;
    [self.infoTextView setValue:@50 forKey:@"limit"];
    [self.scrollView addSubview:self.infoTextView];
    
    /* 商铺详细介绍 */
    self.detailInfoTextView = [[SZTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoTextView.frame)+padding, width, 300)];
    self.detailInfoTextView.placeholder = @"商铺详细介绍 (500字以内)";
    self.detailInfoTextView.text = self.merchantModel.details;
    [self.scrollView addSubview:self.detailInfoTextView];
    
    /* 提交按钮 */
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(22, CGRectGetMaxY(self.detailInfoTextView.frame)+padding, width-44, 40);
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"提  交" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setBackgroundColor:[UIColor redColor]];
    [self.scrollView addSubview:submitButton];
    self.scrollView.contentSize = CGSizeMake(width, CGRectGetMaxY(submitButton.frame)+padding);
}

#pragma mark - <VPViewControllerDelegate>
- (void)pickImageFinished:(UIImage *)image {
    if (image) {
        [self.managerView addImage:image];
    }
}

- (void)submit {
    NSDictionary *params = [self verifyInputData];
    if (params) {
        [S_R LB_PostWithURLString:[URLService updateBusinessIntroduceUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSLog(@"----------------上传照片:%@",responseObject);
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
            if (commonModel.code == SUCCESS_CODE) {
                [MBProgressHUD showSuccessToast:@"修改店铺成功" inView:self.view completionHandler:nil];
                if (self.callbackHandler) {
                    self.callbackHandler(self);
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        } WithController:self];
    }
}

- (NSDictionary *)verifyInputData {
    NSString *introduce = [self.infoTextView.text removeWhiteSpacesFromString];
    if (introduce.length <= 0) {
        [MBProgressHUD showFailToast:@"请输入商铺简价" inView:self.view completionHandler:nil];
        return nil;
    }
    
    NSString *details = [self.detailInfoTextView.text removeWhiteSpacesFromString];
    if (details.length <= 0) {
        [MBProgressHUD showFailToast:@"请输入商铺详情介绍" inView:self.view completionHandler:nil];
        return nil;
    }
    
    // NSArray *images = self.managerView.images;
    /** 图片可选
    if (images.count <= 0) {
         [MBProgressHUD showFailToast:@"商铺图片为空" inView:self.view completionHandler:nil];
         return nil;
    }*/
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *updloadImageUrl = [self.managerView addImageStrings];
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSString *deleteImageUrl = [self.managerView deleteImageStrings];
    NSArray *rurur = @[
                       @{@"name":@"updloadImageUrl",@"detailStr":updloadImageUrl},
                       @{@"name":@"deleteImageUrl",@"detailStr":deleteImageUrl},
                       @{@"name":@"introduce",@"detailStr":introduce},
                       @{@"name":@"details",@"detailStr":details},
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
    
    NSDictionary *parms = @{@"updloadImageUrl" : updloadImageUrl,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign,@"deleteImageUrl":deleteImageUrl,@"introduce":introduce,@"details":details};


   
    return parms;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

@end
