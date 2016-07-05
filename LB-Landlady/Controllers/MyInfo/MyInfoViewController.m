//
//  MyInfoViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyBasicInfoViewController.h"
#import "MyMerchantViewController.h"
#import "MyMerchantAddViewController.h"
#import "MyGoodsSourceViewController.h"
#import "NSString+Helper.h"
#import "HomeServiceMallViewController.h"
#import "ZZContainerViewController.h"
#import "OthersViewController.h"
#import "LoginViewController.h"
#import "MyMerchantListViewController.h"
#import "MyMessageAllViewController.h"
#import "MyMessageOrderViewController.h"
#import "MyMessageSystemViewController.h"
#import "FunctionIntroductionVC.h"
#import "MyMessageCustomViewController.h"
#import "AboutUsVC.h"
#import "URLService.h"
#import "CommonModel.h"
#import "ZZBadgeView.h"
#import "UIViewController+Login.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "RootViewController.h"
#import "MyMessageManager.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+ZZNavigationItem.h"
#import "UITabBar+ZZCustomBadge.h"

@interface MyInfoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

/** 登录界面 */
// @property (weak, nonatomic) IBOutlet UILabel  *vipLabel;
@property (weak, nonatomic) IBOutlet UILabel  *nameLabel;
// @property (weak, nonatomic) IBOutlet UILabel  *locationLabel;

/** 未登录界面 */
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

/** 版本号 */
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

/**
 *  信息标识，比如99+
 */
@property (weak, nonatomic) IBOutlet ZZBadgeView *badgeView;

@property (nonatomic) NSMutableArray *messageArray;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.tableView.sectionFooterHeight     = 0;
    self.versionLabel.text                 = [NSString getMyApplicationVersion];
    self.iconImageView.layer.cornerRadius  = self.iconImageView.bounds.size.width/2.0;
    self.iconImageView.layer.masksToBounds = YES;
    
    [self refresh];
}

// 刷新顶部UI信息
- (void)refresh {
    if (App_User_Info.haveLogIn) {
        [self haveLogIn];
    } else {
        [self notLogIn];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    // [self refresh];
    
    // 当在故事板中设置，暂且写此
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    [self fetchMessageData];
}

/** 登录 */
- (IBAction)login:(id)sender {
    LoginViewController *controller = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    controller.callbackHandler = ^(id obj) {
        [self refresh];
    };
    UINavigationController *nivController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nivController animated:YES completion:nil];
}

// 已登录
- (void)haveLogIn {
    self.loginButton.hidden            = YES;
    self.nameLabel.hidden              = NO;
    self.iconImageView.hidden          = NO;
    self.iconImageView.backgroundColor = [UIColor yellowColor];
    self.nameLabel.text                = App_User_Info.myInfo.userModel.username;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:App_User_Info.myInfo.userModel.userImage] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
}

// 未登录
- (void)notLogIn {
    self.nameLabel.hidden   = YES;
    self.loginButton.hidden = NO;
    self.iconImageView.image = [UIImage imageNamed:@"default_1_1"];
}

#pragma mark - button actions

// 更多
- (IBAction)more:(id)sender {
    if (!App_User_Info.haveLogIn) { // 如果没有登陆，进功能引导页
        [self loginWithInfoType:@"other" callback:^(id model) {
            [self refresh]; // 登陆成功后刷新界面
        }];
    } else {
        OthersViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([OthersViewController class]) bundle:nil] instantiateInitialViewController];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

// 我的资料
- (IBAction)myInfo:(id)sender {
    if (App_User_Info.haveLogIn) {
        MyBasicInfoViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyBasicInfoViewController class]) bundle:nil] instantiateInitialViewController];
        controller.dataModel = App_User_Info.myInfo;
        controller.callbackHandler = ^(id obj) {
            UIImage *headImage = (UIImage *)obj;
            self.iconImageView.image = headImage;
            self.nameLabel.text      = App_User_Info.myInfo.userModel.nickName;
        };
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [self loginWithInfoType:@"material" callback:^(id model) {
            NSLog(@"%@", model);
        }];
    }
}

// 我的商铺
- (IBAction)myMerchant:(id)sender {
    if (App_User_Info.haveLogIn == NO) { // 如果没有登陆，则去登陆
        [self loginWithInfoType:@"store" callback:^(id model) {
            [self refresh];
        }];
        return;
    }
    if (App_User_Info.myInfo.userModel.defaultBusiness.length <= 0) { // 如果没有商铺，增加商铺
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
        [weakself.navigationController pushViewController:controller animated:YES];
    } else {
        MyMerchantViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantViewController class]) bundle:nil] instantiateInitialViewController];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

// 我的货源
- (IBAction)myGoodsResource:(id)sender {
//    if (App_User_Info.haveLogIn) {
//        if (App_User_Info.myInfo.user.business_bound.length <= 0) { // 如果没有商铺id，进入增加商铺页面
//            MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
//            __weak __typeof(self) weakself = self;
//            controller.callbackHandler = ^(id obj) {
//                [weakself.navigationController popViewControllerAnimated:YES];
//            };
//            controller.hidesBottomBarWhenPushed = YES;
//            [weakself.navigationController pushViewController:controller animated:YES];
//        } else {
//            MyGoodsSourceViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyGoodsSourceViewController class]) bundle:nil] instantiateInitialViewController];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//    } else {
//        [self loginWithInfoType:@"mySource" callback:^(id model) {
//            
//        }];
//    }
//    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return indexPath.row == 0 ? kScreenWidth/4 : 70.0f;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            break;
        case 1: {
            [self gotoMyMessage]; // 我的消息
        }
            break;
        case 2: {
            switch (indexPath.row) {
                case 0: { // 功能介绍
                    // TODO:
                    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"FunctionIntroductionVC" bundle:nil];
                    FunctionIntroductionVC * functionVC = [SB instantiateInitialViewController];
                    functionVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:functionVC animated:YES];
                    
                }
                    break;
                case 1: {
                    // TODO:
                    [@"4006602289" phoneCall];
                }
                    break;
                case 2: {
                    // TODO:
                    NSLog(@"版本号");
                }
                    break;
                default:
                    break;
            }
            // TODO:
            NSLog(@"");
        }
            break;
        case 3: {
            // 关于我们
            AboutUsVC * aboutUS = [[AboutUsVC alloc]init];
            aboutUS.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUS animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.001 : 10;
}

/** 我的消息 */
- (void)gotoMyMessage {
    if (App_User_Info.haveLogIn == NO) {
        [self loginWithInfoType:@"news" callback:^(id model) {
            
        }];
        return;
    }
    if (App_User_Info.myInfo.userModel.defaultBusiness.length !=0) {
        /** 全部 | 系统消息 | 订单消息 | 订制消息 */
        MyMessageAllViewController *allController       = [MyMessageAllViewController viewControllerWithTitle:@"全部"];
        MyMessageSystemViewController *systemController = [MyMessageSystemViewController viewControllerWithTitle:@"系统消息"];
        MyMessageOrderViewController *orderController   = [MyMessageOrderViewController viewControllerWithTitle:@"订单消息"];
        MyMessageCustomViewController *customController = [MyMessageCustomViewController viewControllerWithTitle:@"订制消息"];
        
        ZZContainerViewController *containerController = [[ZZContainerViewController alloc] init];
        [containerController makeConfiguration:^(ZZContainerConfiguration *configuration) {
            configuration.viewControllers = @[allController, systemController, orderController, customController];
            configuration.contentHeight = kScreenHeight - self.navigationController.navigationBar.frame.size.height - kTopbarHeight;
            // 当切换到具体的控制器
            configuration.didChangeControllerHandler = ^(UIViewController *controller) {
                MyMessageBaseViewController *baseController = (MyMessageBaseViewController *)controller;
                [baseController didShow];
            };
        }];
        
        containerController.title                    = @"我的消息";
        containerController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:containerController animated:YES];
        
        /**
         *  为了没有破坏ZZContainerViewController的原始封装性，此处把导航条右上的按钮加在这里
         */
        __weak __typeof(ZZContainerViewController *)weakContainer = containerController;
        __block UIButton *editButton = [ZZActionButton actionButtonWithType:UIButtonTypeSystem frame:CGRectMake(0, 0, 40, 40) title:@"编辑" image:nil clickHandler:^{
            editButton.selected = !editButton.selected;
            MyMessageAllViewController *controller = weakContainer.viewControllers[0]; // 全部
            editButton.selected ? [controller edit] : [controller done];
        }];
        [editButton setTitle:@"删除" forState:UIControlStateSelected];
        [editButton setTintColor:[UIColor clearColor]];
        [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        containerController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    }else
    {
        MyMerchantAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantAddViewController class]) bundle:nil] instantiateInitialViewController];
        __weak __typeof(self) weakself = self;
        controller.callbackHandler = ^(id obj) {
            [weakself.navigationController popViewControllerAnimated:YES];
        };
        controller.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:controller animated:YES];
    }
   
}

- (void)fetchMessageData {
    self.badgeView.badgeValue = 0;
    if (App_User_Info.haveLogIn == NO) {
        self.badgeView.badgeValue = 0;
        return;
    }
    
    [MyMessageManager handleMessageWithCallback:^(NSArray *messageArray) {
        NSInteger count = 0;
        for (MyMessageModel *message in messageArray) {
            if (message.is_read == NO) {
                ++count;
            }
        }
        // self.badgeView.badgeValue = messageArray.count;
        self.badgeView.badgeValue = count;
        if (count > 0) {
            [self.tabBarController.tabBar showBadge];
        } else {
            [self.tabBarController.tabBar hideBadge];
        }
    }];
}

#pragma mark - <LoginManagerProtocol>
- (void)handleLogin:(LoginStatus)status {
    switch (status) {
        case LoginStatusSuccess:
            [self refresh];
            break;
        case LogoutStatusSuccess:
            [self refresh];
            break;
        default:
            break;
    }
}

@end
