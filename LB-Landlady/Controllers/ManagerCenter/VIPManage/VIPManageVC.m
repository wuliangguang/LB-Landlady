//
//  VIPManageVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "VIPManageVC.h"
#import "VipAddModel.h"
#import "SwitchPage.h"
#import "VIPDetailTVC.h"
//#import "TestModel.h"


@interface VIPManageVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton * rightButton;
    
    UITableView * tableview;
    BOOL is_search;
    NSInteger _page;
}
@property(nonatomic,strong)UITextField * searchTF;
@property(nonatomic,strong)NSMutableArray * vipArr;
@property(nonatomic,strong)NSMutableArray * searchVipArr;
@property(nonatomic,strong)NSMutableArray * contents;
@property(nonatomic,strong)SwitchPage *sp;
@property(nonatomic,copy)NSString * pageIndex;
@end

@implementation VIPManageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员管理";
    is_search = YES;
    
    NSMutableArray *left = [NSMutableArray array];
    NSMutableArray *mid = [NSMutableArray array];
    NSMutableArray *right = [NSMutableArray array];
    NSMutableArray *arrFour = [NSMutableArray array];
    NSMutableArray *arrFive = [NSMutableArray array];
    NSMutableArray *arrSix = [NSMutableArray array];
    _contents = [[NSMutableArray alloc]initWithObjects:left,mid,right,arrFour,arrFive,arrSix, nil];
    _vipArr = [[NSMutableArray alloc]init];
//    tableview.footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerReresh)];
    
    [self getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
        [_contents replaceObjectAtIndex:0 withObject:array];
    }];
    [self setUpRightItem];
    
}

- (void)initSwitchPageView
{
    _sp = [[SwitchPage alloc]initWithFrame:self.view.bounds];
    _sp.titles = @[@"全部",@"1级",@"2级",@"3级",@"4级",@"5级"];
    __weak typeof(self) weakSelf = self;
    
    _sp.indexSelected = ^(NSInteger index)
    {
        switch (index) {
            case 0: {
                [weakSelf getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:index withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
            default:
            {
                [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:index withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
        }
    };
    _sp.contents = _contents;
    [self.view addSubview:_sp];
    
    _sp.selectedModel = ^(VipAddModel *model)
    {
        NSLog(@"%@",model.associator_phone);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"VIPDetailTVC" bundle:nil];
        VIPDetailTVC * detailTVC = [sb instantiateInitialViewController];
        detailTVC.deltSuccessBlock = ^{
            [tableview removeFromSuperview];
            tableview = nil;
            [weakSelf.searchTF removeFromSuperview];
            weakSelf.searchTF = nil;
            [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
            [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
            is_search = YES;
            switch ([weakSelf.pageIndex integerValue]) {
                case 0: {
                    [weakSelf getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                        [weakSelf.contents replaceObjectAtIndex:[weakSelf.pageIndex integerValue] withObject:array];
                        weakSelf.sp.contents = weakSelf.contents;
                    }];
                    break;
                }
                default:
                {
                    [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                        [weakSelf.contents replaceObjectAtIndex:[_pageIndex integerValue] withObject:array];
                        weakSelf.sp.contents = weakSelf.contents;
                    }];
                    break;
                }
            }

        };
        detailTVC.successBlock = ^{
            switch ([weakSelf.pageIndex integerValue]) {
                case 0: {
                    [weakSelf getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                        [weakSelf.contents replaceObjectAtIndex:[weakSelf.pageIndex integerValue] withObject:array];
                        weakSelf.sp.contents = weakSelf.contents;
                    }];
                    break;
                }
                default:
                {
                    [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                        [weakSelf.contents replaceObjectAtIndex:[_pageIndex integerValue] withObject:array];
                        weakSelf.sp.contents = weakSelf.contents;
                    }];
                    break;
                }
            }
        };
        detailTVC.model = model;
        [weakSelf.navigationController pushViewController:detailTVC animated:YES];
        
    };
    _sp.tableViewHeaderMethod = ^(NSInteger index)
    {
        _pageIndex = [NSString stringWithFormat:@"%d",index];
        switch (index) {
            case 0: {
                [weakSelf getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:index withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
            default:
            {
                [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:index withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
        }
    };
    _sp.tableViewFooterMethod = ^(NSInteger index,NSInteger pageCount)
    {
        NSLog(@"%td,%td",index,pageCount);
        switch (index) {
            case 0: {
                [weakSelf getAllVipsLevel:@"" withPageNum:[NSString stringWithFormat:@"%d",pageCount-1] withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:index withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
            default:
            {
                [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:[NSString stringWithFormat:@"%d",pageCount-1] withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:index withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
        }
    };
}



#pragma mark =======setUI============
-(void)setUpNavigationView
{
    if (self.searchTF == nil) {
        self.searchTF = [[UITextField alloc]initWithFrame:CGRectMake(40, 10, kScreenWidth-100 ,28)];
        self.searchTF.borderStyle = UITextBorderStyleRoundedRect;
        self.searchTF.placeholder = @"搜索会员";
        self.searchTF.keyboardType = UIKeyboardTypeNumberPad;
        self.searchTF.font = [UIFont systemFontOfSize:14];
        self.searchTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(5, 2, 18, 18)];
        self.searchTF.leftViewMode = UITextFieldViewModeAlways;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.searchTF.leftView.frame];
        self.searchTF.delegate = self;
//        self.searchTF.returnKeyType = UIReturnKeySearch;
        imageView.image = [UIImage imageNamed: @"search"];
        [self.searchTF.leftView addSubview:imageView];
        [self.navigationController.navigationBar addSubview:self.searchTF];
    }
//    NSTextAttachment
    [self.searchTF becomeFirstResponder];
 
}
-(void)setUpRightItem
{
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [rightButton addTarget:self action:@selector(searchBttonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
#pragma mark ------ButtonClick------
-(void)searchBttonClick:(UIButton *)button
{
//    [_sp removeFromSuperview];
    if (is_search) {
        if (tableview == nil) {
            [self initTableView];
        }
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:LD_COLOR_TEN forState:UIControlStateNormal];
        //    button.enabled = NO;
        [self setUpNavigationView];
        is_search = !is_search;
    }else
    {
        [tableview removeFromSuperview];
        tableview = nil;
        [self.searchTF removeFromSuperview];
        self.searchTF = nil;
        [button setTitle:@"搜索" forState:UIControlStateNormal];
        [button setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
        is_search = !is_search;
        
    }
    
}
-(void)initTableView
{
    _searchVipArr = [[NSMutableArray alloc]init];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
}

#pragma mark --------TextFieldDelegate --------

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES ;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self searchVIPWithNum:textField.text];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    rightButton.enabled = YES;
    [rightButton setTitleColor:LD_COLOR_TEN forState:UIControlStateNormal];
    [self.searchTF resignFirstResponder];
    
    return YES ;
}
#pragma mark =========tableView delegate ==========
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    VipAddModel * model = _searchVipArr[indexPath.row];
    cell.textLabel.text = model.associator_phone;
    cell.textLabel.font = LK_FONT_SIZE_FOUR;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"VIPDetailTVC" bundle:nil];
    VIPDetailTVC * detailTVC = [sb instantiateInitialViewController];
    __weak typeof(self) weakSelf = self;
    detailTVC.deltSuccessBlock = ^{
        [tableview removeFromSuperview];
        tableview = nil;
        [weakSelf.searchTF removeFromSuperview];
        weakSelf.searchTF = nil;
        [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
        [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
        is_search = YES;
        switch ([weakSelf.pageIndex integerValue]) {
            case 0: {
                [weakSelf getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:[weakSelf.pageIndex integerValue] withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
            default:
            {
                [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:[_pageIndex integerValue] withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
        }
        
    };

    detailTVC.successBlock = ^{
        [tableview removeFromSuperview];
        tableview = nil;
        [weakSelf.searchTF removeFromSuperview];
        weakSelf.searchTF = nil;
        [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
        [rightButton setTitleColor:LD_COLOR_ONE forState:UIControlStateNormal];
        is_search = YES;
        switch ([weakSelf.pageIndex integerValue]) {
            case 0: {
                [weakSelf getAllVipsLevel:@"" withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:[weakSelf.pageIndex integerValue] withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
            default:
            {
                [weakSelf getAllVipsLevel:[NSString stringWithFormat:@"%ld",(long)index] withPageNum:@"0" withArrBlock:^(NSMutableArray *array) {
                    [weakSelf.contents replaceObjectAtIndex:[_pageIndex integerValue] withObject:array];
                    weakSelf.sp.contents = weakSelf.contents;
                }];
                break;
            }
        }
    };
    detailTVC.model = self.searchVipArr[indexPath.row];
    [self.navigationController pushViewController:detailTVC animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchVipArr.count;
}
#pragma mark ------NetRequest-------
#pragma mark - 查询每个等级的VIP -
- (void)getAllVipsLevel:(NSString * )level withPageNum:(NSString *)currentPageNum withArrBlock:(void (^)(NSMutableArray * array))arrayBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getAssociatorByBusinessAndLevel];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:App_User_Info.myInfo.userModel.defaultBusiness  forKey:@"businessId"];
        [param setObject:level forKey:@"level"];
        [param setObject:currentPageNum forKey:@"currentPageNum"];
        [param setObject:@20 forKey:@"pageSize"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                _vipArr = [VipAddModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"associatorList"]];
                arrayBlock(_vipArr);
            }
            
            if (_sp == nil) {
                [self initSwitchPageView];
            }
            NSLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
#pragma mark - 按照号码查询VIP - 
-(void)searchVIPWithNum:(NSString * )num
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getAssociatorByPhone];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:num forKey:@"phone"];
        [params setObject:@"0" forKey:@"currentPageNum"];
        [params setObject:@"20" forKey:@"pageSize"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"getAssociatorByPhone=====%@",responseObject);
            _searchVipArr = [VipAddModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"associatorList"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableview reloadData];
            });
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchTF resignFirstResponder];
    [self.searchTF removeFromSuperview];
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
