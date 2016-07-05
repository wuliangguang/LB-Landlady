//
//  MyGoodsSourceViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceViewController.h"
#import "PowerfulBannerView.h"
#import "MyGoodsSourceContactViewController.h"
#import "MySourcePublishViewController.h"
#import "MyGoodsSourceOrderViewController.h"
#import "MyGoodsSourceShopViewController.h"
#import "ZZShowMessage.h"
#import "AdDataModel.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+ShowWeb.h"

@interface MyGoodsSourceViewController ()

@property (nonatomic) NSArray *adArray;
@end

@implementation MyGoodsSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self getAdvertisement];
}

- (void)initUI {
    self.title                     = @"我的货源";
    PowerfulBannerView *bannerView = [[PowerfulBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/4.0)];
    bannerView.items               = self.adArray;
    UIPageControl *pageControl     = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height-15, kScreenWidth, 15)];
    pageControl.numberOfPages      = self.adArray.count;
    bannerView.pageControl         = pageControl;
    bannerView.autoLooping         = YES;
    [bannerView addSubview:pageControl];
    bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        UIImageView *view = (UIImageView *)reusableView;
        if (!view) {
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
            // view.clipsToBounds = YES;
            AdModel *adModel = (AdModel *)item;
            [view sd_setImageWithURL:[NSURL URLWithString:adModel.image] placeholderImage:[UIImage imageNamed:@"my_source_banner_default"]];
        }
        return view;
    };
    bannerView.bannerDidSelectBlock = ^(PowerfulBannerView *banner, NSInteger index) {
        if (_adArray.count > 0) {
            AdModel *adModel = self.adArray[index];
            [self showWebWithTitle:adModel.name url:adModel.url];
        }
    };
    self.tableView.tableHeaderView = bannerView;
    
    self.tableView.sectionFooterHeight = 0;
}

- (void)getAdvertisement {
    [S_R LB_GetWithURLString:[URLService getAdvertismentURL] WithParams:@{@"type" : s_ad_my_merchant} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[AdDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            AdDataModel *dataModel = commonModel.data;
            self.adArray = dataModel.advertList;
            PowerfulBannerView *bannerView = (PowerfulBannerView *)self.tableView.tableHeaderView;
            bannerView.items = self.adArray;
            // [bannerView reloadData];
        }
    } failure:^(NSError *error) {
    } WithController:self];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: { // 联系货源
                    MyGoodsSourceContactViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyGoodsSourceContactViewController class]) bundle:nil] instantiateInitialViewController];
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                case 1: { // 发布货源
                    MySourcePublishViewController *controller = [[MySourcePublishViewController alloc] init];
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                case 2: { // 下单记录
                    MyGoodsSourceOrderViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyGoodsSourceOrderViewController class]) bundle:nil] instantiateInitialViewController];
                    [self.navigationController pushViewController:controller animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1: { // 货源商城
            MyGoodsSourceShopViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyGoodsSourceShopViewController class]) bundle:nil] instantiateInitialViewController];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        default:
            break;
    }
}


@end
