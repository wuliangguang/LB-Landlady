//
//  MyMerchantChangeNameViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/22/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantChangeNameViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "ZZCommonLimit.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface MyMerchantChangeNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation MyMerchantChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"联系人";
    UIButton *button = [self addStandardRightButtonWithTitle:@"保存" selector:@selector(save)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.nameField setValue:@6 forKey:@"limit"];
    [ZZCommonLimit nameLimit:self.nameField];
    
    self.nameField.text = self.name;
}

- (void)save {
    NSDictionary *params = [self verifyInputData];
    if (params) {
        [S_R LB_PostWithURLString:[URLService updateBusinessLogoUrl] WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSLog(@"%@", responseString);
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
            if (commonModel.code == SUCCESS_CODE) {
                App_User_Info.myInfo.businessModel.contactName = self.nameField.text;
                if (self.callbackHandler) {
                    self.callbackHandler(self.nameField.text);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } else {
                [MBProgressHUD showFailToast:commonModel.msg inView:self.view completionHandler:nil];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        } WithController:self];
    }
}

- (NSDictionary *)verifyInputData {
    NSString *contactName = self.nameField.text;
    if (contactName.length <= 0) {
        [MBProgressHUD showFailToast:@"姓名不可为空" inView:self.view completionHandler:nil];
        return nil;
    }
    
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    NSArray *rurur = @[
                       @{@"name":@"contactName",@"detailStr":contactName},
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
    
    NSDictionary *parms = @{@"contactName" : contactName,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};

    return parms;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

@end
