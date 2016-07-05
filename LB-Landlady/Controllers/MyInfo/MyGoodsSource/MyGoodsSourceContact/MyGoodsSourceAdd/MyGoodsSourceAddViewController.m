//
//  MyGoodsSourceAddViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceAddViewController.h"
#import "ZZImagePickerManager.h"
#import <LianBiLib/Base64.h>
#import "ScaleImage.h"
#import "UIImage+Base64.h"
#import "ZZCommonLimit.h"
#import "MBProgressHUD+ZZConvenience.h"


@interface MyGoodsSourceAddViewController ()

/* 图片视图 */
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

/* 联系人姓名 */
@property (weak, nonatomic) IBOutlet UITextField *contactNameField;

/* 联系人电话 */
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneField;

/* 货源店名称 */
@property (weak, nonatomic) IBOutlet UITextField *goodsSourceNameField;

/* 货源内容 */
@property (weak, nonatomic) IBOutlet UITextField *goodsSourceContent;
/**
 *  盛放联系人图片的，避免默认图片和自选图片混淆
 */
@property(nonatomic,strong)UIImage * imageBuffer;
@end

@implementation MyGoodsSourceAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title                         = @"新增联系人";
    self.tableView.sectionFooterHeight = 0;
    
    [ZZCommonLimit nameLimit:self.contactNameField];
    [ZZCommonLimit wordCountLimit:self.goodsSourceNameField num:20];
    [ZZCommonLimit wordCountLimit:self.goodsSourceContent num:20];
    [ZZCommonLimit phoneLimit:self.contactPhoneField];
}

// 确认
- (IBAction)confirm:(id)sender {
    NSDictionary *params = [self verifyInputData];
    if (params) {
        [S_R LB_GetWithURLString:[URLService addProductSourceContactsUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSLog(@"%@", responseString);
            //  {"isTrue":1,"code":"200","msg":"successfull!"}
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
            if (commonModel.code == SUCCESS_CODE) {
                if (self.completionHandler) {
                    self.completionHandler(self);
                }
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showFailToast:@"新增联系人失败" inView:self.view completionHandler:nil];
        } WithController:self];
    }
}

- (void)showToast:(NSString *)message {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:ERROR_DELAY];
}

- (NSDictionary *)verifyInputData {
    // 图片
    NSString *img = _imageBuffer.base64Str;
    if (img.length <= 0) {
        [self showToast:@"联系人图片不可以为空"];
        return nil;
    }
    
    // 联系人姓名
    NSString *name = self.contactNameField.text;
    if ([name removeWhiteSpacesFromString].length <= 0) {
        [self showToast:@"请输入联系人姓名"];
        return nil;
    }
    
    // 联系电话
    NSString *phone = self.contactPhoneField.text;
    if ([phone removeWhiteSpacesFromString].length <= 0) {
        [self showToast:@"请输入联系电话"];
        return nil;
    }
    
    // 货源店名称
    NSString *sourceName = self.goodsSourceNameField.text;
    if ([sourceName removeWhiteSpacesFromString].length <= 0) {
        [self showToast:@"请输入货源店名称"];
        return nil;
    }
    
    // 货源内容
    NSString *sourceDetail = self.goodsSourceContent.text;
    if ([sourceDetail removeWhiteSpacesFromString].length <= 0) {
        [self showToast:@"请输入货源内容"];
        return nil;
    }
    
    NSDictionary *dict = @{
                           @"userId" : App_User_Info.myInfo.userModel.userId,
                           @"img" : img,
                           @"name" : name,
                           @"phone" : phone,
                           @"sourceName" : sourceName,
                           @"sourceDetail" : sourceDetail
                           };
    return dict;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            [ZZImagePickerManager pickImageInController:self completionHandler:^(UIImage *image) {
                self.addImageView.image = image;
                _imageBuffer = image;
                
            }];
            break;
        }
            
        default:
            break;
    }
}

@end
