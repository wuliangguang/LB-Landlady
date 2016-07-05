//
//  MyMerchantAddViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantAddViewController.h"
#import "MyMerchantCategoryViewController.h"
#import "ZZImagePickerManager.h"
#import "MyMerchantAddModel.h"
#import "MyMerchantAddressViewController.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "ZZShowMessage.h"
#import "IphoneNumberHelper.h"
#import "Address.h"
#import "CommonModel.h"
#import "MerchantInfoManager.h"
#import <LianBiLib/Base64.h>
#import "CustomImage.h"
#import "ProvinceView.h"
@interface MyMerchantAddViewController () <UITableViewDataSource, UITextFieldDelegate>

/** 商户名称 */
@property (weak, nonatomic) IBOutlet UITextField *merchantNameField;

/** 联系人姓名 */
@property (weak, nonatomic) IBOutlet UITextField *contactNameField;

/** 联系人手机号 */
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneField;

/** 行业分类 */
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

/** 商铺地址 */
@property (weak, nonatomic) IBOutlet UILabel *merchantAddresLabel;

/** Button: + */
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UITableViewCell *businessLicenseCell;
@property(nonatomic,strong) UIView * maskView;
@property (nonatomic) MyMerchantAddModel *addModel;

@end

@implementation MyMerchantAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.tableView.sectionFooterHeight = 0.0f;
    self.title = @"新增商铺";
    self.contactPhoneField.delegate = self;
}

/** 增加营业执照 */
- (IBAction)addBusinessLicense:(id)sender {
    [ZZImagePickerManager pickImageInController:self completionHandler:^(UIImage *image) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.addButton.frame];
        imageView.image = image;
       // CGSize size = CGSizeMake(ceil(imageView.frame.size.width), ceil(imageView.frame.size.height));
        self.addModel.license = [Base64 stringByEncodingData:UIImageJPEGRepresentation([CustomImage compressImage:image maxSize:1000*1024], 1.0)];
        [self.businessLicenseCell.contentView addSubview:imageView];
        [self.addButton removeFromSuperview];
    }];
}

/** 提交 */
- (IBAction)submit:(id)sender {
    if ([self verifyInputData]) {
        NSDate *date = [[NSDate alloc]init];
        
        NSString *serNum = [NSString toUUIDString];
        NSString *source = @"app";
        NSString *reqTime;
        reqTime = [date toString];
        
        NSString *businessName = self.addModel.businessName;
        NSString *address = self.addModel.address;
        NSString *industryId = self.addModel.industryId;
        NSString *userId = App_User_Info.myInfo.userModel.userId;
        NSString *license = self.addModel.license;
        NSString *contactName = self.addModel.contactName;
        NSString *phone = self.addModel.phone;
        NSString *provinceId = self.addModel.provinceId;
        NSArray *rurur = @[
                           @{@"name":@"businessName",@"detailStr":businessName},
                           @{@"name":@"address",@"detailStr":address},
                           @{@"name":@"industryId",@"detailStr":industryId},
                           @{@"name":@"userId",@"detailStr":userId},
                           @{@"name":@"license",@"detailStr":license},
                           @{@"name":@"phone",@"detailStr":phone},
                           @{@"name":@"provinceId",@"detailStr":provinceId},
                           @{@"name":@"contactName",@"detailStr":contactName},
                           @{@"name":@"source",@"detailStr":source},
                           @{@"name":@"serNum",@"detailStr":serNum},
                           @{@"name":@"reqTime",@"detailStr":reqTime},
                           ];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dict in rurur) {
            SendRequestModel *model = [[SendRequestModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [dataArray addObject:model];
        }
        NSString *sign = [SendRequestModel backStrFromeArr:dataArray];
        
        NSDictionary *parms = @{@"businessName" : businessName, @"address" : address,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"industryId":industryId,@"userId":userId,@"license":license,@"phone":phone,@"sign":sign,@"provinceId":provinceId,@"contactName":contactName};

        [S_R LB_PostWithURLString:[URLService addBusinessByBUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
            /**
             * 逻辑
             if (成功 && 原来没有绑定店铺) {
                绑定店铺 // 第一家店铺
             }
             */
            NSLog(@"---------------添加店铺:%@",responseObject);
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[AddMerchantDataModel class]];
            if (commonModel.code == SUCCESS_CODE) {
                // 没有绑定过店铺
                if (App_User_Info.myInfo.userModel.defaultBusiness.length <= 0) {
                    [self bindMerchant:commonModel.data];
                } else {
                    [MBProgressHUD showSuccessToast:@"新增成功" inView:self.view completionHandler:nil];
                    if (self.callbackHandler) {
                        self.callbackHandler(self.addModel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"-----------------error:%@", error);
        } WithController:self];
    }
}

// 如果是第一次新增店铺，则绑定
- (void)bindMerchant:(AddMerchantDataModel *)model {
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *businessId = model.businessId;
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSArray *rurur = @[
                       @{@"name":@"businessId",@"detailStr":businessId},
                       @{@"name":@"userId",@"detailStr":userId},
                       @{@"name":@"source",@"detailStr":source},
                       @{@"name":@"serNum",@"detailStr":serNum},
                       @{@"name":@"reqTime",@"detailStr":reqTime},
                       ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in rurur) {
        SendRequestModel *model = [[SendRequestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    NSString *sign = [SendRequestModel backStrFromeArr:dataArray];
    
    NSDictionary *parms = @{@"businessId" : businessId, @"userId" : userId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    //NSDictionary *dict = @{@"userId" : App_User_Info.myInfo.userModel.userId, @"businessId" : model.businessId};
    [S_R LB_GetWithURLString:[URLService getChangeBusinessOnAppUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"--------------第一次增加店铺设置默认%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            App_User_Info.myInfo.userModel.defaultBusiness = model.businessId;
            
            if (self.callbackHandler) {
                self.callbackHandler(self);
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

// 验证输入数据
- (BOOL)verifyInputData {
    // opentime closetime不传
    if ([self.merchantNameField.text removeWhiteSpacesFromString].length <= 0) {
        [MBProgressHUD showFailToast:@"请输入店铺名称" inView:self.view completionHandler:nil];
        return NO;
    }
    if (self.addModel.license == nil) {
        [MBProgressHUD showFailToast:@"请上传营业执照" inView:self.view completionHandler:nil];
        return NO;
    }
    if (self.addModel.industryId == nil) {
        [MBProgressHUD showFailToast:@"请选择行业" inView:self.view completionHandler:nil];
        return NO;
    }
    if (self.addModel.address == nil) {
        [MBProgressHUD showFailToast:@"行业地址不能为空" inView:self.view completionHandler:nil];
        return NO;
    }
    if ([self.contactNameField.text removeWhiteSpacesFromString].length <= 0) {
        [MBProgressHUD showFailToast:@"请输入联系人姓名" inView:self.view completionHandler:nil];
        return NO;
    }
    if ([self.contactPhoneField.text isVAlidPhoneNumber] == NO) {
        [MBProgressHUD showFailToast:s_phone_error inView:self.view completionHandler:nil];
        return NO;
    }
    self.addModel.businessName = self.merchantNameField.text;
    self.addModel.contactName  = self.contactNameField.text;
    self.addModel.phone        = self.contactPhoneField.text;
    self.addModel.userId       = App_User_Info.myInfo.userModel.userId;
    return YES;
}

- (MyMerchantAddModel *)addModel {
    if (_addModel == nil) {
        _addModel = [[MyMerchantAddModel alloc] init];
    }
    return _addModel;
}

#pragma mark - <UITableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2: {
            switch (indexPath.row) {
                case 0: { // 行业分类
                    MyMerchantCategoryViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantCategoryViewController class]) bundle:nil] instantiateInitialViewController];
                    controller.callbackHandler = ^(IndustryModel *model) {
                        self.addModel.industryId = model.industryId;
                        self.categoryLabel.text = model.industryName;
                    };
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                    case 1:
                {
                    
                    [self addProvinceView];
                }
                    break;
                case 2: { // 商铺地址
                    MyMerchantAddressViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddressViewController class]) bundle:nil] instantiateInitialViewController];
                    controller.callbackHandler = ^(id anAddress) {
                        Address *address = (Address *)anAddress;
                        self.merchantAddresLabel.text = address.address;
                        self.addModel.address         = address.address;
                        self.addModel.latitude        = address.latitude;
                        self.addModel.longitude       = address.longitude;
                    };
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}
- (void)addProvinceView{
    _maskView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
    _maskView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    //UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    //[_maskView addGestureRecognizer:recognizer];
    
    ProvinceView *provinceView = [[ProvinceView alloc] init];
    provinceView.backgroundColor = [UIColor whiteColor];
    provinceView.userInteractionEnabled = YES;
    provinceView.frame = CGRectMake(0, kScreenHeight/2 , kScreenWidth, kScreenHeight/2 + 20);
    provinceView.proinvceBlcok = ^(NSString *provinceId,NSString *province){
       // NSLog(@"--------------------%@---------%@",provinceId,province);
        self.provinceLabel.text = province;
        self.addModel.province = province;
        self.addModel.provinceId = provinceId;
        [self tapGesture];
    } ;
    provinceView.addTouchBlcok = ^(){
        [self tapGesture];
    };
    [_maskView addSubview:provinceView];
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
}
-(void)tapGesture{
    
    [UIView animateWithDuration:0.5 animations:^{
        [_maskView removeFromSuperview];
    }];
}
#pragma mark - <UITextFieldDelegate>
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.contactPhoneField)
    {
        if ([aString length] > 11)
        {
            textField.text = [aString substringToIndex:11];
            return NO;
        }
        BOOL isIphoneNumber = [IphoneNumberHelper iphoneNumberInputRule:aString InputString:string];
        return isIphoneNumber;
    }
    return YES;
}

@end
