//
//  MyMerchantListViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantListViewController.h"
#import "MyMerchantListCell.h"
#import "UIViewController+ZZNavigationItem.h"
#import "CommonModel.h"
#import "MerchantListDataModel.h"
#import "UITableView+ZZHiddenExtraLine.h"
#import "MyMerchantAddViewController.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "MerchantInfoManager.h"

@interface MyMerchantListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyMerchantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self fetchWebData];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyMerchantListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyMerchantListCell class])];
}

- (void)fetchWebData {
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    
    NSString *userId = App_User_Info.myInfo.userModel.userId;
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
    
    NSDictionary *parms = @{@"userId" : userId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService getBusinessByUserUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"-------------------获取店铺列表:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MerchantListDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            self.dataArray = [NSMutableArray arrayWithArray:[(MerchantListDataModel *)commonModel.data modelList]];
            for (MerchantListItemModel *item in self.dataArray) {
                NSLog(@"------------------item.businessId:%@",item);
                if ([item.businessId isEqualToString:App_User_Info.myInfo.userModel.defaultBusiness]) {
                    item.check = YES;
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

- (void)initUI {
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *button = [self addStandardRightButtonWithTitle:@"保存" selector:@selector(save)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.title = @"切换商户";
    [self.tableView hiddenExtraLine];
}

// 切换商铺 -> 切换成功后获取店铺信息 -> 更新 App_User_Info
- (void)save {
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
     MerchantListItemModel *item = self.choosedMerchantItem;
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSString *businessId = item.businessId;
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
    
    NSDictionary *parms = @{@"userId" : userId,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService getChangeBusinessOnAppUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            [self getMerchantInfo];
        }
    } failure:^(NSError *error) {
    } WithController:self];
}

// 获取商铺信息
- (void)getMerchantInfo {
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSString *businessId = self.choosedMerchantItem.businessId;
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
    
    NSDictionary *parms = @{@"userId" : userId,@"businessId":businessId,@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [MerchantInfoManager merchantInfoWithInfo:parms completionHandler:^(MerchantInfoStatus status) {
        switch (status) {
            case MerchantInfoStatusSuccess: {
                [MBProgressHUD showSuccessToast:@"保存成功" inView:self.view completionHandler:nil];
                if (self.callbackHandler) {
                    self.callbackHandler(self);
                }
            } break;
                
            default:
                break;
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 71.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMerchantListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyMerchantListCell class]) forIndexPath:indexPath];
    MerchantListItemModel *itemModel = self.dataArray[indexPath.row];
    cell.model = itemModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (MerchantListItemModel *itemModel in self.dataArray) {
        itemModel.check = NO;
    }
    
    MerchantListItemModel *itemModel = self.dataArray[indexPath.row];
    itemModel.check = YES;
    self.choosedMerchantItem = itemModel;
    [self.tableView reloadData];
}

/**
 *  新增商铺
 */
- (IBAction)addMerchant:(id)sender {
    MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
    controller.callbackHandler = ^(id obj) {
        // AddMerchantDataModel *model = (AddMerchantDataModel *)obj;
        [self fetchWebData]; // 新增店铺成功，重新刷新数据
    };
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
