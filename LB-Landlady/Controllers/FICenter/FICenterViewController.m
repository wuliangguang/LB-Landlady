//
//  FICenterViewController.m
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "FICenterViewController.h"
#import "FinancialProductsTVC.h"
#import "IncomeTableVC.h"
#import "ADCCell.h"
#import "OtherSectionCCell.h"
#import "TodayIncomeCCell.h"
#import "IncomeDataModel.h"
#import "CommonModel.h"
#import "AdDataModel.h"
#import "ZZShowMessage.h"
#import "NSString+Formatter.h"
#import "UIViewController+Login.h"
#import "UIViewController+ShowWeb.h"
#import "NotificationHelper.h"
#import "MyMerchantAddViewController.h"
#import "MyMerchantListViewController.h"

@interface FICenterViewController ()

// @property(nonatomic) NSMutableArray *callBackArr;
@property (nonatomic,assign) float  totalIncomeMoney;

@property(nonatomic)MBProgressHUD *Mbp;
@property(nonatomic,strong)UITableView *table;
@property (nonatomic) NSArray *adArray;

@end

@implementation FICenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"财务室";
    self.view.backgroundColor = Color(237, 237, 237);
    
#warning netRequest
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
#warning netRequest
            [self getCountByBusiness];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView.header endRefreshing];
            });
        }];
    });
    
    // 广告 和登录，店铺无关
    [self getAdvertisement];
    
    // 和登录相关
    [self handleLogin:LoginStatusUnknown];
    
    // 经营总收入改变，注册通知
    [NotificationHelper registNotificationOfIncomeChangeWithObserser:self selector:@selector(incomeDidChange:)];
}

// 经营总收入发生变化
- (void)incomeDidChange:(NSNotification *)notification {
    [self getCountByBusiness];
}

- (void)getAdvertisement {
    [S_R LB_GetWithURLString:[URLService getAdvertismentURL] WithParams:@{@"type" : s_ad_financial} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[AdDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            AdDataModel *dataModel = commonModel.data;
            self.adArray = dataModel.advertList;
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]]; // 局部刷新
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

// 获取经营总收入
- (void)getCountByBusiness {
    if (App_User_Info.myInfo.userModel.defaultBusiness == nil) {
        return;
    }
    NSString *userId = App_User_Info.myInfo.userModel.userId;
    NSString *queryType = @"total";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",queryType,userId,key];
    sign = [sign mdd5];
    NSDictionary *parms = @{@"userId":userId,@"queryType":queryType,@"sign":sign};
    [S_R LB_PostWithURLString:[URLService getCountByBusiness] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"----------------------财务室total:%@",responseObject);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IncomeDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            IncomeDataModel *income = commonModel.data;
            TodayIncomeCCell *cell = (TodayIncomeCCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.income = income;
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

#pragma mark ----collectionViewDelegate-----
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0://经营收入
            {
                if (App_User_Info.haveLogIn) {
                    if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0) {
                        UIStoryboard * story             = [UIStoryboard storyboardWithName:@"Income" bundle:nil];
                        IncomeTableVC * tableVC          = [story instantiateViewControllerWithIdentifier:@"incomeTableVC"];
                        tableVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:tableVC animated:YES];
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
                    [self loginWithInfoType:@"manage" callback:nil];
                }
                
            }
                break;
            case 1://财务管理
            {
                if (App_User_Info.haveLogIn) {
                    if (App_User_Info.myInfo.userModel.defaultBusiness.length !=0) {
                        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MarketDetail_MVC_SB" bundle:nil];//MarketDetailMainViewController
                        UIViewController *vc = [storyBoard instantiateInitialViewController];
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                       
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
                    [self loginWithInfoType:@"finance" callback:nil];
                }
            }
                break;
//            case 2://我要理财
//            {
//                if (App_User_Info.haveLogIn) {
//                    if (App_User_Info.myInfo.user.business_bound.length !=0) {
//                        FinancialProductsTVC * financialProTvc = [[FinancialProductsTVC alloc]initWithStyle:UITableViewStyleGrouped];
//                        financialProTvc.hidesBottomBarWhenPushed = YES;
//                        [self.navigationController pushViewController:financialProTvc animated:YES];
//                    }else
//                    {
//                        MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
//                        controller.hidesBottomBarWhenPushed = YES;
//                        __weak __typeof(self) weakself = self;
//                        controller.callbackHandler = ^(id obj) {
//                            __strong __typeof(weakself) strongSelf = weakself;
//                            [self.navigationController popViewControllerAnimated:NO];
//                            
//                            // 进入店铺列表
//                            MyMerchantListViewController *listController = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
//                            listController.callbackHandler = ^(id obj) {
//                                NSLog(@"%@", obj);
//                            };
//                            [strongSelf.navigationController pushViewController:listController animated:YES];
//                        };
//                        [self.navigationController pushViewController:controller animated:YES];
//                    }
//                    
//                }else
//                {
//                    [self loginWithInfoType:@"financialTransactions" callback:nil];
//                }
//            }
//                break;
//                
            default:
                break;
        }
    }
    
}
//每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 150);
    }else if (indexPath.section == 1)
    {
        return CGSizeMake(kScreenWidth, kScreenWidth/4.0+15);
    }else
    {
        return CGSizeMake(kScreenWidth/2.0, 65);
    }
}
//返回每个 section 和边界上下左右的间距，设置的时候要考虑 item 的大小，不能有冲突
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 5, 0);
        case 1:
            return UIEdgeInsetsMake(5, 0, 10, 0);
        case 2:
            return UIEdgeInsetsMake(0, 0, 10, 0);
        default:
            return UIEdgeInsetsZero;
    }
}
//设置两行之间的最小间距，实际显示的时候，不一定是这个值，可能是一个比这个值大的值，这是我们不能控制的，由系统处理的。
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//设置两个 item 之间的左右最小间距，实际情况同上
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 1;
    }else
    {
        //        return 6;
        return 10;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            TodayIncomeCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"income" forIndexPath:indexPath];
            NSLog(@"%@", [NSString stringWithFormat:@"%f", _totalIncomeMoney].formatPrice);
            cell.incomeLabel.text = [NSString stringWithFormat:@"%f", _totalIncomeMoney].formatPrice;
            return cell;
        }
        case 1: // 广告
        {
            ADCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ad" forIndexPath:indexPath];
            // 点击cell，要有事件
//            NSMutableArray *imageArray = [NSMutableArray array];
//            for (AdModel *model in self.adArray) {
//                [imageArray addObject:model.image];
//            }
//            cell.adsDataArr = imageArray;
            
            cell.adsDataArr = self.adArray;
            cell.callbackHandler = ^(id obj) {
                AdModel *adModel = (AdModel *)obj;
                [self showWebWithTitle:adModel.name url:adModel.url];
            };
            return cell;
        }
        case 2:
        {
            OtherSectionCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            NSArray * imgArr         = @[@"canmou",@"guanli",@"dianyuan",@"huoyuan",@"licai"];
            NSArray * titleArr       = @[@"经营收入",@"财务管理",@"我要理财"];
            NSArray * detailArr      = @[@"日常生意小工具",@"资金流转管理",@"收入增值，生财有道"];
            
            
            if (indexPath.row<2) {
                cell.bottomLine.alpha       = 1;
                cell.rightLine.alpha        = 1;
                cell.headerImageView.alpha  = 1;
                cell.headerLabel.alpha      = 1;
                cell.datailIntroLabel.alpha = 1;
                cell.headerImageView.image  = [UIImage imageNamed:imgArr[indexPath.row]];
                cell.headerLabel.text       = titleArr[indexPath.row];
                cell.datailIntroLabel.text  = detailArr[indexPath.row];
            }else if(indexPath.row>= 2)
            {
                cell.bottomLine.alpha       = 0;
                cell.rightLine.alpha        = 0;
                cell.headerImageView.alpha  = 0;
                cell.headerLabel.alpha      = 0;
                cell.datailIntroLabel.alpha = 0;
                
            }
            
            return cell;
        }
        default:
            return cell;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
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
            [self getCountByBusiness];
            break;
        }
        case LoginStatusFail: {
            break;
        }
        case LogoutStatusSuccess: { // 退出登录成功
            [self clean];
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
            break;
        }
        case MerchantInfoStatusFail: {
            break;
        }
        default:
            break;
    }
}
- (void)clean {
    IncomeDataModel *income ;
    income.totalAmt = @"0";
    TodayIncomeCCell *cell = (TodayIncomeCCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.income = income;
    

    
}

@end
