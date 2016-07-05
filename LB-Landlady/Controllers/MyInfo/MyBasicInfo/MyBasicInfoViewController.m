//
//  MyBasicInfoViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/14/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyBasicInfoViewController.h"
#import "CustomImage.h"
#import "UIViewController+ZZNavigationItem.h"
#import "MyBasicChangePasswordViewController.h"
#import "ZZCommonLimit.h"
#import "UIViewController+Login.h"
#import "NSUserDefaults+Helper.h"
#import "CommonModel.h"
#import "MYInfo_showModel.h"
#import <UIImageView+WebCache.h>
#import <LianBiLib/Base64.h>
#import "MBProgressHUD+ZZConvenience.h"

@interface MyBasicInfoViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property(nonatomic,strong)MBProgressHUD * hud;



/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;

/**
 *  联系电话
 */
@property (weak, nonatomic) IBOutlet UITextField *contactPhone;

/**
 *  紧急联系人
 */
@property (weak, nonatomic) IBOutlet UITextField *emergencyField;

/**
 *  紧急联系人电话
 */
@property (weak, nonatomic) IBOutlet UITextField *emergencyPhoneField;

@end

@implementation MyBasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self fetchWebData];
}

// 获取我的资料
- (void)fetchWebData {
    NSString *userId = App_User_Info.myInfo.userModel.userId == nil ? @"" : App_User_Info.myInfo.userModel.userId;
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSArray *rurur = @[
                       @{@"name":@"userId",@"detailStr":userId},
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
    NSDictionary *parms = @{ @"userId" : userId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService myInfo] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"----------------------获取用户信息:%@",responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        if ([dict[@"code"] integerValue] == SUCCESS_CODE) {
            NSDictionary *dataDict   = dict[@"data"];
            MYInfo_sales *saleModel      = [[MYInfo_sales alloc]init];
            //[saleModel setValuesForKeysWithDictionary:dataDict];
            saleModel.userImage = dataDict[@"userImage"];
            saleModel.urgentPhone = dataDict[@"urgentPhone"];
            saleModel.mobile = dataDict[@"mobile"];
            saleModel.urgent = dataDict[@"urgent"];
            saleModel.username = dataDict[@"username"];
            saleModel.userId = dataDict[@"userId"];
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:saleModel.userImage] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
            self.nickNameField.text       = [saleModel.username removeWhiteSpacesFromString];
            self.contactPhone.text        = saleModel.mobile;
            self.emergencyField.text      = [saleModel.urgent removeWhiteSpacesFromString];
            self.emergencyPhoneField.text = [saleModel.urgentPhone removeWhiteSpacesFromString];
            App_User_Info.myInfo.userModel.nickName = [saleModel.username removeWhiteSpacesFromString];
            App_User_Info.myInfo.userModel.userImage      = saleModel.userImage;
        } else  {
            [self notHaveDown];
        }
    } failure:^(NSError *error) {
        [self notHaveDown];
        NSLog(@"%@", error);
    } WithController:self];

}
- (void)notHaveDown{
    if (self.dataModel.userModel.userImage == nil) {
        
    }else{
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.userModel.userImage] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
    }
    self.nickNameField.text       = [self.dataModel.userModel.username removeWhiteSpacesFromString];
    self.contactPhone.text        = self.dataModel.userModel.mobile;
    self.emergencyField.text      = [self.dataModel.userModel.urgent removeWhiteSpacesFromString];
    //NSLog(@"-=-=-=-=--------------self.dataModel.userModel.urgentPhone:%@",self.dataModel.userModel.urgentPhone);
    self.emergencyPhoneField.text = [self.dataModel.userModel.urgentPhone removeWhiteSpacesFromString];
}
- (void)initUI {
    self.title                            = @"我的资料";
    self.tableView.sectionFooterHeight    = 0.01;
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width/2.0;
    self.iconImageView.clipsToBounds      = YES;
    UIButton *button                      = [self addStandardRightButtonWithTitle:@"保存" selector:@selector(save)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ZZCommonLimit nickNameLimit:self.nickNameField];
    [ZZCommonLimit nameLimit:self.emergencyField];
    [self.emergencyPhoneField setValue:@11 forKey:@"limit"];
}

// 保存
- (void)save {
    NSDictionary *params = [self verifyInputData];
    if (params) {
        [S_R LB_PostWithURLString:[URLService modifyUserInfo] WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSLog(@"---------------------修改用户信息%@",responseObject);
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
            if (commonModel.code == SUCCESS_CODE) {
                App_User_Info.myInfo.userModel.nickName     = _nickNameField.text;
                App_User_Info.myInfo.userModel.mobile       = _contactPhone.text;
                App_User_Info.myInfo.userModel.urgent       = _emergencyField.text;
                App_User_Info.myInfo.userModel.urgentPhone = _emergencyPhoneField.text;
                self.callbackHandler(self.iconImageView.image);
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        } WithController:self];
    }
}

#pragma mark ------NetRequest-------
- (NSDictionary *)verifyInputData {
    // 头像
    UIImage *iconImage = self.iconImageView.image;
 //   NSLog(@"--------------------------------头像:%@",iconImage);
    if (iconImage == nil) {
        return [self showError:@"请上传头像"];
    }
    NSString *userImage = [Base64 stringByEncodingData:UIImageJPEGRepresentation(iconImage, 1.0)];
    
    // 昵称
    NSString *username = self.nickNameField.text;
    if (username.length <= 0) {
        return [self showError:@"请输入昵称"];
    }
    
    
    // 联系电话
    NSString *mobile = self.contactPhone.text;
    if (mobile.length <= 0) {
        return [self showError:@"请输入联系电话"];
    }
    
    // 紧急联系人
    NSString *urgent = self.emergencyField.text;
    if (urgent.length <= 0) {
        return [self showError:@"请输入紧急联系人"];
    }
    
    // 紧急联系人电话
    NSString *urgentPhone = self.emergencyPhoneField.text;
    if (urgentPhone.length <= 0) {
        return [self showError:@"请输入紧急联系人电话"];
    }
    
//    NSDictionary *dict = @{@"userId" : App_User_Info.myInfo.userModel.userId,
//                           @"userName" : userName,
//                           @"password" : password,
//                           @"mobile" : mobile,
//                           @"image" : image,
//                           @"urgent" : urgent,
//                           @"urgentPhone" : urgentPhone
//                           };
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSArray *rurur = @[
                       @{@"name":@"userId",@"detailStr":userId},
                       @{@"name":@"username",@"detailStr":username},
                       @{@"name":@"mobile",@"detailStr":mobile},
                       @{@"name":@"urgent",@"detailStr":urgent},
                       @{@"name":@"urgentPhone",@"detailStr":urgentPhone},
                       @{@"name":@"userImage",@"detailStr":userImage},
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
    //NSLog(@"----------------sign:%@",sign);
    NSDictionary *parms = @{@"mobile" : mobile, @"userId" : userId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign,@"userImage":userImage,@"username":username,@"urgent":urgent,@"urgentPhone":urgentPhone};
    return parms;
}

- (id)showError:(NSString *)error {
    [MBProgressHUD showFailToast:error inView:self.view completionHandler:nil];
    return nil;
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: { // 更改头像
                    [self.view endEditing:YES];
                    UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
                    [sheet showFromTabBar:self.tabBarController.tabBar];
                    break;
                }
                case 2: { // 登录密码
                    MyBasicChangePasswordViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyBasicChangePasswordViewController class]) bundle:nil] instantiateInitialViewController];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                default:
                    break;
            }
        }
            break;
        case 1:
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self showImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self showImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        default:
            break;
    }
}

- (void)getPhotoFromLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //指定几总图片来源
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate                 = self;
        imagePicker.allowsEditing            = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"Error accessing photo library!"
                                                      delegate:nil
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        CGSize size = CGSizeMake(floor(self.iconImageView.frame.size.width), floor(self.iconImageView.frame.size.height));
        self.iconImageView.image = editedImage;//[CustomImage imageWithOrigin:editedImage size:size];
    }];
}

- (void)showImagePickerWithType:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate                 = self;
        imagePicker.allowsEditing            = YES;
        imagePicker.sourceType               = type;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error accessing photo library!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

@end
