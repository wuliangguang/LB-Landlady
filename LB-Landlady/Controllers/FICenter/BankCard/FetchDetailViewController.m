//
//  FetchDetailViewController.m
//  MeZoneB_Bate
//
//  Created by 喻晓彬 on 15/10/28.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "FetchDetailViewController.h"
#import "MD_Main_HeaderView.h"
#import "CheckDetailCell.h"
#import "CheckDetailModel.h"
#import "MJRefresh.h"
#import "EveryTradeDetailTableVC.h"


@interface FetchDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tabelView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *selectedButton;
@property(nonatomic,assign)NSInteger index;
@end

@implementation FetchDetailViewController


- (void)loadCheckDetailUrl {
    
    NSString *pathStr = [URLService getWithDrawByUserIdUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
    [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
        FMLog(@"==responseObject ==%@ ",responseObject);
        if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
            self.dataArr = [CheckDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabelView reloadData];
            });
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
    
}
//- (void)refreshData {
//    __block FetchDetailViewController *weakSelf = self;
//    [self.tabelView addHeaderWithCallback:^{
//        _page = 1;
//        [weakSelf loadCheckDetailUrl];
//    }];
//    
//}
//- (void)loadMoreData {
//    __block FetchDetailViewController *weakSelf = self;
//    [self.tabelView addFooterWithCallback:^{
//        weakSelf.page ++;
//        [weakSelf loadCheckDetailUrl];
//    }];
//    
//    
//}
//- (void)endrefresh {
//    [self.tabelView footerEndRefreshing];
//    [self.tabelView headerEndRefreshing];
//    
//    
//}
#pragma mark ------VC Life CYC 生命周期-----
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadCheckDetailUrl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易明细";
    [self creatTabelView];
    self.view.backgroundColor = Color(237, 237, 237);
}
- (void)creatTabelView {
    self.dataArr = [[NSMutableArray alloc]init];
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"MarketDetailMainHeader" owner:self options:nil];
    MD_Main_HeaderView *view = views[0];
    view.tag = 1300;
    UIImageView *textLeftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 13, 13)];
    textLeftView.image = [UIImage imageNamed:@"Safe_Account_Icon"];
    view.noticeLabel.leftView = textLeftView;
    view.noticeLabel.leftViewMode = UITextFieldViewModeAlways;
    view.priceLabel.text = self.totalCount;
    view.titleLabel.text = @"账户余额（元）";
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/5*2);
    
    UIView * bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/5*2 + 40 )];
    
    
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor redColor];
    UIView *bottomView  = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth/5*2, kScreenWidth, 40)];
    bottomView.userInteractionEnabled = YES;
    for (int i=0; i<2; i++) {
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(kScreenWidth/2.0*i,9 , kScreenWidth/2.0, 30);
        if (i==0) {
            [leftButton setTitle:@"提现记录" forState:UIControlStateNormal];
                        leftButton.selected = YES;
            _selectedButton = leftButton;
        }else
        {
            [leftButton setTitle:@"充值记录" forState:UIControlStateNormal];
        }
        [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        leftButton.tag = 900+i;
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bottomView.backgroundColor = Color(227, 227, 227);
        leftButton.backgroundColor = [UIColor whiteColor];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:leftButton];
        
    }
    
        _label.frame = CGRectMake(3, 37, kScreenWidth/2.0-6, 2);
    [bottomView addSubview:_label];
    
    UILabel * bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    bottomLab.backgroundColor = Color(227, 227, 227);
    [bottomView addSubview:bottomLab];
    UILabel * midLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.0-1, 15, 1, 21)];
    midLab.backgroundColor = Color(227, 227, 227);
    [bottomView addSubview:midLab];
    
    
    [bigView addSubview:view];
    [bigView addSubview:bottomView];
    
    self.tabelView.tableHeaderView = bigView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"check_detail"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CheckDetailCell" owner:self options:nil]lastObject];
        
    }
    //    NSArray * reverseArr = [[self.dataArr reverseObjectEnumerator] allObjects];
    CheckDetailModel *model = self.dataArr[indexPath.row];
    [cell showCellWirhModel:model];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 40;
//}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    _label = [[UILabel alloc]init];
//    _label.backgroundColor = [UIColor redColor];
//    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    view.userInteractionEnabled = YES;
//    for (int i=0; i<2; i++) {
//        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        leftButton.frame = CGRectMake(kScreenWidth/2.0*i,9 , kScreenWidth/2.0, 30);
//        if (i==0) {
//            [leftButton setTitle:@"提现记录" forState:UIControlStateNormal];
////            leftButton.selected = YES;
//            _selectedButton = leftButton;
//        }else
//        {
//            [leftButton setTitle:@"充值记录" forState:UIControlStateNormal];
//        }
//        [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//        leftButton.tag = 900+i;
//        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        view.backgroundColor = Color(227, 227, 227);
//        leftButton.backgroundColor = [UIColor whiteColor];
//        leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:leftButton];
//        
//    }
//    
////    _label.frame = CGRectMake(3, 37, kScreenWidth/2.0-6, 2);
//    [view addSubview:_label];
//    
//    UILabel * bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
//    bottomLab.backgroundColor = Color(227, 227, 227);
//    [view addSubview:bottomLab];
//    UILabel * midLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.0-1, 15, 1, 21)];
//    midLab.backgroundColor = Color(227, 227, 227);
//    [view addSubview:midLab];
//    return view;
//    
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EveryTradeDetailTableVC * everyDetail = [[EveryTradeDetailTableVC alloc]init];
    CheckDetailModel *model = self.dataArr[indexPath.row];
    NSLog(@"--------------model:%@",model.amount);
    everyDetail.model = model;
    [self.navigationController pushViewController:everyDetail animated:YES];
}
#pragma mark --------btnClick-------
-(void)buttonClick:(UIButton *)sender
{
    if (_selectedButton != sender) {//两个不相等才执行操作
        _selectedButton.selected = NO;//已经选中的，取消选中
        sender.selected = YES;//将要选中的，选中
        _selectedButton = sender;//把指针指向已经选中的按钮
    }
    
    _label.frame = CGRectMake((kScreenWidth/2.0)*(sender.tag-900)+3, 37, kScreenWidth/2.0-6, 2);
    if (sender.tag == 900) {
        //提现记录
        [self.dataArr removeAllObjects];
        [self loadCheckDetailUrl];
    }else
    {
        [self.dataArr removeAllObjects];
        [self.tabelView reloadData];
        
#warning 充值记录
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
