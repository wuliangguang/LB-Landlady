//
//  MCenterViewController.m
//  LB-Landlady
//
//  Created by d2space on 16/1/7.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MCenterViewController.h"
#import "MCQCodeCellTableViewCell.h"
#import "MCManageCell.h"
#import "GM_ADCell.h"
#import "Mommon_income_titleCell.h"
#import "MCOrderCell.h"
//#import "HorizenalCollection.h"

#import "WaiterManagerViewController.h"
#import "ProductManageTVC.h"
#import "TradeManageTVC.h"
#import "TradeManageVC.h"

#import "MyMerchantAddViewController.h"
#import "InfoWebViewController.h"
#import "MerchantListItemModel.h"

#import "VIPManageTVC.h"
#import "UIViewController+Login.h"
#import "MyMerchantViewController.h"
#import "MyMerchantListViewController.h"
#import "HorizenalCollectionModel.h"
#import "ViewForGL.h"
#import <UIImageView+WebCache.h>
#import "HomeServiceMallViewController.h"
#import "OrderListDetailModel.h"
#import <UIImageView+WebCache.h>
#import "ZZShowMessage.h"
#import "AdDataModel.h"
#import "OrderListTVC.h"
#import "UIViewController+ShowWeb.h"
#import "OrderDetailTVC.h"
#import <LianBiLib/CustomQrCode.h>
#import "OrderGenerateVC.h"
#import "NotificationHelper.h"
#import "OrderQueryViewController.h"
#import "MerchantInfoManager.h"
#import "ProdManagerTableViewController.h"
@interface MCenterViewController ()
{
    UIImageView * QCodeImageview;/**<点击二维码出来的大的ImageView*/
    GLViewForScroller * viewForScroller;
}
@property(nonatomic,strong) UIView * maskView;
@property(nonatomic,strong)NSMutableArray * serviceArr;
@property(nonatomic,strong)NSArray * modelArr;
@property (nonatomic) NSArray *adArray;
@property (nonatomic)MerchantListItemModel *model;
@end

@implementation MCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.backgroundColor = LD_COLOR_THIRTEEN;
    _serviceArr = [[NSMutableArray alloc] init];
    
    [self getMoreService];
    /**
     *  注册tableview的Cell
     */
    [self.tableview registerNib:[UINib nibWithNibName:@"MCQCodeCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"code"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MCManageCell class]) bundle:nil] forCellReuseIdentifier:@"manage"];
    
    // 获取广告
    // [self performSelector:@selector(getAdvertisement) withObject:nil afterDelay:15];
    [self getAdvertisement];
    
    // 和登录相关
    [self handleLogin:LoginStatusUnknown];
    
    // 经营总收入改变，注册通知
    [NotificationHelper registNotificationOfIncomeChangeWithObserser:self selector:@selector(incomeDidChange:)];
}

- (void)getAdvertisement {
    [S_R LB_GetWithURLString:[URLService getAdvertismentURL] WithParams:@{@"type" : s_ad_manage_center} WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[AdDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            AdDataModel *dataModel = commonModel.data;
            self.adArray = dataModel.advertList;
//            [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic]; // 刷新广告
            [self.tableview reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

- (void)setupArr {
    // 往_serviceArr添加第一第二个元素以及最后一个元素
    HorizenalCollectionModel * model0   = [[HorizenalCollectionModel alloc]init];
    model0.icon =@"1";model0.mall_name  = @"订单明细";
    HorizenalCollectionModel * model1   = [[HorizenalCollectionModel alloc]init];
    model1.icon = @"2";model1.mall_name = @"会员管理";
    [_serviceArr insertObject:model0 atIndex:0];
    [_serviceArr insertObject:model1 atIndex:1];
    HorizenalCollectionModel * model2 = [[HorizenalCollectionModel alloc]init];
    model2.icon = @"orderIcon";
    model2.mall_name = @"订单生成";// @"订单管理";
    [_serviceArr insertObject:model2 atIndex:2];
    HorizenalCollectionModel * lastModel = [[HorizenalCollectionModel alloc]init];
    lastModel.icon = @"morelandly";
    lastModel.mall_name = @"添加更多";
    [_serviceArr addObject:lastModel];
}

#pragma mark -------tableViewDelegate ------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            MCQCodeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"code" forIndexPath:indexPath];
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
                businessName = [businessName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *qrContent = [NSString stringWithFormat:@"%@%@%@%@%@",s_backOffPath,s_centerPath,businessId,s_wecchatPath,businessName];
                NSLog(@"------------businessName:%@",qrContent);
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
                
                /**
                if (App_User_Info.myInfo.user.business_bound.length != 0) {
                    [UIView animateWithDuration:0.1 animations:^{
                        _maskView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
                        UIVisualEffect * visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                        UIVisualEffectView * visualEffectView = [[UIVisualEffectView alloc]initWithEffect:visualEffect];
                        visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight+20);
                        visualEffectView.backgroundColor = LD_COLOR_THIRTEEN;
                        visualEffectView.alpha = 0.5;
                        [_maskView addSubview:visualEffectView];
                        
                        QCodeImageview = [[UIImageView alloc] init];
                        QCodeImageview.backgroundColor = [UIColor whiteColor];
                        QCodeImageview.bounds = CGRectMake(0, 0, kScreenWidth-80, kScreenWidth-80);
                        QCodeImageview.center =  _maskView.center;
                        // QCodeImageview.image = [UIImage imageNamed: @"QCode"];
                        QCodeImageview.image = [CustomQrCode createQRCodeWithValue:App_User_Info.myInfo.user.business_bound WithRed:0 Green:0 Blue:0 WithSize:QCodeImageview.bounds.size.width];
                        [_maskView addSubview:QCodeImageview];
                        [self.view.window addSubview:_maskView];
                        
                        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
                        [_maskView addGestureRecognizer:recognizer];
                        
                    }];
                }
                 */
            };
            
            /**
             *  点击查看店铺详情的Block回调
             */
            cell.CheckStoreDetailBlock = ^{
                FMLog(@"点击了查看店铺详情");
                if (App_User_Info.haveLogIn ) {
                    if (App_User_Info.myInfo.userModel.defaultBusiness.length !=0) {
                        [self changeMerchant]; // 有店铺，查看详情
                        /**
                        MyMerchantViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantViewController class]) bundle:nil] instantiateInitialViewController];
                        controller.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:controller animated:YES];
                         */
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
        };
        case 1: {
            /**
             *  产品管理 店员管理cell
             */
            MCManageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"manage" forIndexPath:indexPath];
            /**
             *  产品管理button的点击回调
             */
            cell.productBtnBlock=^{
                FMLog(@"产品管理button的点击回调");
//                // FMLog(@"%d",App_User_Info.myInfo.user.business_bound.length);
                if (App_User_Info.haveLogIn ) {
                    // FMLog(@"%@",App_User_Info.myInfo.user.business_bound);
                    if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0) {
//                        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"ProductManageTVC" bundle:nil];
//                        ProductManageTVC * productTVC = [sb instantiateInitialViewController];
//                        productTVC.hidesBottomBarWhenPushed = YES;
//                        [self.navigationController pushViewController:productTVC animated:YES];
//                        MBProgressHUD* mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                        mbp.mode = MBProgressHUDModeText;
//                        mbp.labelText = @"正在建设中...";
//                        [mbp hide:YES afterDelay:1];
                        
                        ProdManagerTableViewController *product = [[ProdManagerTableViewController alloc]init];
                        product.title = @"产品管理";
                        product.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:product animated:YES];
                    }else
                    {
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
                    [self loginWithInfoType:@"product" callback:^(id model) {}];
                }
            };
            
            /**
             *  店员管理 button 的点击回调
             */
            cell.waiterBtnBlock=^{
                // FMLog(@"店员管理 button 的点击回调");
                if (App_User_Info.haveLogIn) {
                    if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0) {
                        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"WaiterManager" bundle:nil];
                        WaiterManagerViewController *vc = [storyBoard instantiateInitialViewController];
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    else
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
                } else {
                    [self loginWithInfoType:@"clerk" callback:^(id model) {
                        
                    }];
                }
                
            };
            return cell;
        }
        case 2: {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                viewForScroller = [[GLViewForScroller alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
                UIButton * leftView = [UIButton buttonWithType:UIButtonTypeCustom];
                [leftView setImage:[UIImage imageNamed: @"service_new_left"] forState:UIControlStateNormal];
                leftView.frame = CGRectMake(2, 60, 20, 20);
                [leftView addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
                [viewForScroller addSubview:leftView];
                UIButton * rightView = [UIButton buttonWithType:UIButtonTypeCustom];
                [rightView setImage:[UIImage imageNamed: @"service_new_right"] forState:UIControlStateNormal];
                rightView.frame = CGRectMake(kScreenWidth-22, 60, 20, 20);
                [rightView addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
                [viewForScroller addSubview:rightView];
                [cell addSubview:viewForScroller];
            }
            viewForScroller.delegate = self;
            [viewForScroller reloadData];
            
            return cell;
        }
        case 3: {
            GM_ADCell * cell = [tableView dequeueReusableCellWithIdentifier:@"gm_ad"];
            if (!cell) {
                cell = [[GM_ADCell alloc] init];
            }
            cell.type = 1;
            cell.adsDataArr = self.adArray;
            cell.callbackHandler = ^(id obj) {
                AdModel *adModel = (AdModel *)obj;
                [self showWebWithTitle:adModel.name url:adModel.url];
            };
            return cell;
        }
        case 4: {
            Mommon_income_titleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MM_titleCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([Mommon_income_titleCell class]) owner:self options:nil]lastObject];
                cell.topLine.alpha = 0;
                cell.bottom.alpha  = 0;
            }
            cell.MM_titleLab.text = [NSString stringWithFormat:@"最近完成的%ld笔交易",_modelArr.count];
            return cell;
        }
        case 5: {
            MCOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MCorderCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCOrderCell" owner:self options:nil]lastObject];
            }
            cell.model = _modelArr[indexPath.row];
            return cell;
        }
            
        default: {
            UITableViewCell * cell = [[UITableViewCell alloc] init];
            return cell;
        };
    }
}

// 经营总收入发生变化-获取最近十笔交易
- (void)incomeDidChange:(NSNotification *)notification {
    [self getTenRecoder];
}

// 进入切换商铺界面
- (void)changeMerchant {
    MyMerchantListViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantListViewController class]) bundle:nil] instantiateInitialViewController];
    controller.choosedMerchantItem = [App_User_Info.myInfo.businessModel convertToMerchantListItemModel];
    controller.callbackHandler = ^(id obj) { // 切换店铺成功回调
        MyMerchantListViewController *controller = (MyMerchantListViewController *)obj;
        MCQCodeCellTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.merchantItem = controller.choosedMerchantItem;
        //self.model = controller.choosedMerchantItem;
        [self.navigationController popViewControllerAnimated:YES];
        // [self fetchWebData:item.business_id];
    };
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 3:case 4:
            return 10;
            
        default:
            return 0.01;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 5:
            return _modelArr.count;
            
        default:
            return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:case 1:
            return 100;
        case 2:
            return 140;
        case 3:
            return kScreenWidth/4.0;
        case 4:
            return 40;
        default:
            return 170;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        UIStoryboard * SB = [UIStoryboard storyboardWithName:@"OrderDetailTVC" bundle:nil];
        OrderDetailTVC * orderTVC = [SB instantiateInitialViewController];
        orderTVC.hidesBottomBarWhenPushed = YES;
        OrderListDetailModel * model = _modelArr[indexPath.row];
        orderTVC.orderId = model.order_id;
//        orderTVC.type = [_status integerValue];
        [self.navigationController pushViewController:orderTVC animated:YES];
    }
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

#pragma mark ------ButtonClick------

-(void)tapGesture:(UITapGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.5 animations:^{
        [_maskView removeFromSuperview];
    }];
}
-(void)leftButtonClick
{
    FMLog(@"%@",NSStringFromCGPoint(viewForScroller.scrollerView.contentOffset))
    if (viewForScroller.scrollerView.contentOffset.x <= 0) {
        viewForScroller.scrollerView.contentOffset = CGPointMake(0, 0);
    }else
    {
        viewForScroller.scrollerView.contentOffset = CGPointMake(viewForScroller.scrollerView.contentOffset.x - kScreenWidth, viewForScroller.scrollerView.contentOffset.y);
    }
}
-(void)rightButtonClick
{
    FMLog(@"%@",NSStringFromCGPoint(viewForScroller.scrollerView.contentOffset))
    NSInteger pageNum = (_serviceArr.count-1)/4;
    if (viewForScroller.scrollerView.contentOffset.x >= pageNum * kScreenWidth) {
        viewForScroller.scrollerView.contentOffset = CGPointMake(pageNum * kScreenWidth, 0);
    }else
    {
        viewForScroller.scrollerView.contentOffset = CGPointMake(viewForScroller.scrollerView.contentOffset.x + kScreenWidth,viewForScroller.scrollerView.contentOffset.y);
    }
}

#pragma mark ------NetRequest-------
-(void)getMoreService
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getMySelfServerMallUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        if (App_User_Info.haveLogIn == NO) {
            [self setupArr];
            return ;
        }
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                //FMLog(@"responseObject===%@",responseObject);
                _serviceArr = [HorizenalCollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"serverMallList"]];
                
                [self setupArr];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}

-(void)getTenRecoder
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getTenOrderList];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        if (App_User_Info.haveLogIn == NO || App_User_Info.myInfo.businessModel.businessId <= 0) {
            return ;
        }

        [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                FMLog(@"responseObject===%@",responseString);
                _modelArr = [OrderListDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"orderList"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
#pragma mark ---GLScrollerViewDelegate---
///item的个数
- (NSInteger)itemNum{
    return _serviceArr.count;
}



///本身的size
- (CGSize)viewSize{
    return CGSizeMake(kScreenWidth, 140);
}

///item size
- (CGSize)itemSize{
    return CGSizeMake(kScreenWidth/2.0, 70);
}

///相邻item横向间距
- (CGFloat)itemHorizenPin{
    return 1;
}

///相邻item竖向间距
- (CGFloat)itemVerticalPin{
    return 1;
}

///返回item的view
- (UIView*)view:(GLViewForScroller*)view itemIndex:(NSInteger)item{
    ViewForGL * glView = [[[NSBundle mainBundle] loadNibNamed:@"ViewForGL" owner:nil options:nil] lastObject];
    glView.bgBTN.tag = item;
    
    HorizenalCollectionModel * model = _serviceArr[item];
    
    if (item<=2) {
        
        glView.iconImageview.image = [UIImage imageNamed:model.icon];
        glView.titleLAB.text = model.mall_name;
        glView.detailLAB.text = model.mall_name;
    }else if (item == _serviceArr.count - 1)
    {
        glView.iconImageview.image = [UIImage imageNamed:model.icon];
        glView.titleLAB.text = model.mall_name;
        glView.detailLAB.text = model.mall_name;
    }else
    {
        [glView.iconImageview sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
        glView.titleLAB.text = model.mall_name;
        glView.detailLAB.text = model.mall_name;

    }
    
    __weak typeof (self) weakSelf = self;
    glView.buttonClickBlock = ^(NSInteger itemIndex){
        if (itemIndex == _serviceArr.count - 1) {
            if (App_User_Info.haveLogIn) {
                [self gotoMoreServiceMall];
            } else {
                [self loginWithInfoType:@"server" callback:^(id model) {
                    
                }];
            }
        }else
        {
            switch (itemIndex) {
                case 0:
                {
                    if (App_User_Info.haveLogIn) {
                        if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0)
                        {
//                            TradeManageTVC * controller = [[TradeManageTVC alloc]initWithStyle:UITableViewStyleGrouped];
//                            controller.hidesBottomBarWhenPushed = YES;
//                            [weakSelf.navigationController pushViewController:controller animated:YES];
                            OrderQueryViewController *order = [[OrderQueryViewController alloc]init];
                            order.string= @"orderDetailButtonClock";
                            order.titleStr = @"订单详情";
                            order.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:order animated:YES];
                        }
                        else
                        {
                            MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
                             __weak __typeof(self) weakself = self;
                            controller.callbackHandler = ^(id obj) { // 新增后，进入店铺列表
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
                    }
                    else
                    {
                        [self loginWithInfoType:@"trade" callback:^(id model) {
                            
                        }];
                    }
                }
                    break;
                case 1:
                {
                    if (App_User_Info.haveLogIn) {
                        if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0)
                        {
                            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"VIPManageTVC" bundle:nil];
                            UIViewController * controller = [sb instantiateInitialViewController];
                            controller.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:controller animated:YES];
                        }
                        else
                        {
                            MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
                            controller.hidesBottomBarWhenPushed = YES;
                            __weak __typeof(self) weakself = self;
                            controller.callbackHandler = ^(id obj) { // 新增后，进入店铺列表
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
                    }
                    else
                    {
                        [self loginWithInfoType:@"vip" callback:^(id model) {
                            
                        }];
                    }
                }
                    break;
                case 2:
                {
                    if (App_User_Info.haveLogIn) {
                        if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0)
                        {
                            // 需求修改：去订单生成
                            OrderGenerateVC *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([OrderGenerateVC class]) bundle:nil] instantiateInitialViewController];
                            UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
                            [self presentViewController:nivController animated:YES completion:nil];
//                            MBProgressHUD* mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                            mbp.mode = MBProgressHUDModeText;
//                            mbp.labelText = @"正在建设中...";
//                            [mbp hide:YES afterDelay:1];
                        }
                        else
                        {
                            MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
                            controller.hidesBottomBarWhenPushed = YES;
                            __weak __typeof(self) weakself = self;
                            controller.callbackHandler = ^(id obj) { // 新增后，进入店铺列表
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
                        [self loginWithInfoType:@"order" callback:^(id model) {
                            
                        }];
                    }
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 4:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }

        
        }
    };
    return glView;
}

// 服务商城 更多
- (void)gotoMoreServiceMall {
    HomeServiceMallViewController *controller = [[HomeServiceMallViewController alloc] init];
    controller.hidesBottomBarWhenPushed       = YES;
    controller.urlString                      = [URLService getServiceMallUrl];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - <LoginManagerProtocol>
- (void)handleLogin:(LoginStatus)status {
    switch (status) {
        case LoginStatusUnknown: {
            if (App_User_Info.haveLogIn ) {
                [self handleLogin:LoginStatusSuccess];
            } else {
                [self handleLogin:LoginStatusFail];
            }
            break;
        }
        case LoginStatusSuccess: {
            [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self getTenRecoder];
            break;
        }
        case LoginStatusFail: {
            break;
        }
        case LogoutStatusSuccess:{
            MCQCodeCellTableViewCell *mccell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            mccell.StoreAddressLab.text =@"";
            mccell.StoreNameLab.text =@"";
        }
            break;
        default:
            break;
    }
}
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
            MCQCodeCellTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.StoreNameLab.text = App_User_Info.myInfo.businessModel.businessName;
            cell.StoreAddressLab.text = App_User_Info.myInfo.businessModel.address;
            break;
        }
        case MerchantInfoStatusFail: {
            break;
        }
        default:
            break;
    }
}
- (void)dealloc {
    [NotificationHelper removeNotificationOfIncomeChangeWithObserver:self object:nil];
}

@end
