//
//  InfoWebViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomeServiceMallViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LoginViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "CollectionViewCell.h"
#import "ServerMallListDataModel.h"
#import "HomeServiceMallHeadView.h"
#import "CommonModel.h"

@interface HomeServiceMallViewController () <UIWebViewDelegate>

@property (nonatomic       ) UIWebView        * webView;
@property (nonatomic,strong) NSMutableArray   * serviceArray;
@property (nonatomic,strong) UIButton         * selectBtn;
@property (nonatomic,strong) UILabel          * redLab;
@property (nonatomic,strong) UICollectionView * collectionView;
@end

@implementation HomeServiceMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self fetchWebData];
    [self fetchOnlineServerWebData];
}

- (void)initUI {
    self.title                = @"服务商城";
    self.view.backgroundColor = [UIColor whiteColor];
    
    HomeServiceMallHeadView *headView = [[HomeServiceMallHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.items = @[@"我的服务", @"线上服务"];
    __weak __typeof(self) weakself = self;
    [headView setCallbackHandler:^(UIButton *button, NSInteger index) {
        if (index == 0) {
            [weakself.view bringSubviewToFront:self.collectionView];
            [self fetchWebData];
        } else {
            [weakself.view bringSubviewToFront:self.webView];
        }
    }];
    [self.view addSubview:headView];
    
    // CollectionView
    CGFloat margin                     = 2.0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    layout.itemSize                    = CGSizeMake((kScreenWidth-3*margin)/2.0, 70);
    layout.minimumInteritemSpacing     = margin;
    layout.minimumLineSpacing          = margin;
    _collectionView                    = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-84) collectionViewLayout:layout];
    _collectionView.backgroundColor    = LD_COLOR_FOURTEEN;
    _collectionView.dataSource         = self;
    _collectionView.delegate           = self;
    _collectionView.pagingEnabled      = YES;
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [self.view addSubview:_collectionView];
    
    // WebView
    self.webView                 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-84)];
    self.webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.webView.delegate        = self;
    // [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self.webView loadHTMLString:@"<html><body>测试数据</body></html>" baseURL:nil];
    [self.view addSubview:self.webView];
    
    [self.view bringSubviewToFront:self.collectionView];
    [self fetchWebData];
}

- (void)fetchWebData {
    if (self.serviceArray == nil) {
        self.serviceArray = [NSMutableArray array];
    }
    [_serviceArray removeAllObjects];
    
    // 获取已有服务商城
    [S_R LB_GetWithURLString:[URLService getMySelfServerMallUrl] WithParams:@{@"userId" : App_User_Info.myInfo.userModel.userId} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[ServerMallListDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            ServerMallListDataModel *dataModel = commonModel.data;
            self.serviceArray = [[NSMutableArray alloc] initWithArray:dataModel.serverMallList];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"获取数据失败");
    } WithController:self];
}

/**
 *  获取线上服务
 */
- (void)fetchOnlineServerWebData {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", [URLService getServeMarket], App_User_Info.myInfo.userModel.userId]]]];
//    [S_R LB_GetWithURLString:[URLService getServeMarket] WithParams:@{@"userId" : App_User_Info.myInfo.user.user_id} WithSuccess:^(id responseObject, id responseString) {
//        NSLog(@"%@", responseString);
//    } failure:^(NSError *error) {
//        
//    } WithController:self];
}

#pragma mark ------CollectionViewDelegate ----------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return _serviceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    
    /**
    NSArray * arr = @[@"交易管理",@"评价管理",@"会员管理",@"设备管理",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    cell.headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%td",indexPath.row + 1]];
    cell.headerLabel.text = arr[indexPath.row];
    cell.datailIntroLabel.text = arr[indexPath.row];
     */

    ServermalllistModel *serverModel = self.serviceArray[indexPath.row];
    cell.serverModel = serverModel;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
}

#pragma mark - <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
}

@end
