//
//  TradeManageTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "TradeManageTVC.h"
#import "TMStatusCell.h"
#import "DataScrollView.h"
#import "OrderDetailTVC.h"
#import "TMButtonCell.h"
#import "FileUtil.h"
#import "NSDate+Escort.h"

#import "DateView.h"
#import "DateClickCell.h"
#import "DatePickerView.h"
#import "OrderListModel.h"



@interface TradeManageTVC ()
{
//    BOOL flag;

}

@property (nonatomic, strong) NSString      *selectedType;

@property (nonatomic, strong) UIView *maskView;
@property(nonatomic,strong)UITableView * TableView;/**<可以选择自定义时间的表*/
@property(nonatomic,assign)NSInteger selectRow;
@property(nonatomic,strong)DateView * dateView;
@property(nonatomic,strong)HeaderView * headerView;

@property(nonatomic,strong)UIView * showView;
@property(nonatomic,strong)DatePickerView * pickerView;
@property(nonatomic,strong)NSMutableArray * modelArr;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,assign)NSInteger pageNum;


@end

@implementation TradeManageTVC



#pragma mark ------NetRequest-------
-(void)getOrderListByBusinessIdDateStatuUrlRequestStartTime:(NSString *)startTime endTime:(NSString *)endTime status:(NSString *)status currentPageNum:(NSString *)currentPageNum
{
    NSString * pathStr = [URLService getOrderListByBusinessIdDateStatuUrl];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:App_User_Info.myInfo.businessModel.businessId forKey:@"businessId"];
    [params setObject:startTime forKey:@"startTime"];
    [params setObject:endTime forKey:@"endTime"];
    [params setObject:status forKey:@"status"];
    [params setObject:currentPageNum forKey:@"currentPageNum"];
    [params setObject:@20 forKey:@"pageSize"];

    [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
        FMLog(@"responseObject == %@",responseString);
        NSArray * arr = [[NSArray alloc]init];
        arr = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"orderList"]];
        if (arr.count != 0) {
            [_modelArr addObjectsFromArray:arr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.footer endRefreshing];
            [self.tableView.header endRefreshing];
        });
    } failure:^(NSError *error) {
        
    } WithController:self];
}
//-(void)getOrderListByBusinessIdDateStatuUrlRequestStartTime:(NSString *)startTime endTime:(NSString *)endTime status:(NSString *)status currentPageNum:(NSString *)currentPageNum
//{
//    NSString * pathStr = [URLService getOrderListByBusinessIdDateStatuUrl];
//    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
//    [params setObject:App_User_Info.myInfo.businessInfo.businessId forKey:@"businessId"];
//    [params setObject:startTime forKey:@"startTime"];
//    [params setObject:endTime forKey:@"endTime"];
//    [params setObject:status forKey:@"status"];
//    [params setObject:currentPageNum forKey:@"currentPageNum"];
//    [params setObject:@20 forKey:@"pageSize"];
//    [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
//        FMLog(@"responseObject == %@",responseString);
//        
//        _modelArr = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"orderList"]];
//    
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    } failure:^(NSError *error) {
//        
//    } WithController:self];
//}

#pragma mark ==========Animation Method =============
-(void)hiddenShadowView:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        _showView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        _pickerView.frame = CGRectMake(0, self.view.frame.size.height +44, self.view.frame.size.width, 1);
        self.tableView.scrollEnabled = YES;
        [_showView removeFromSuperview];
        [_pickerView removeFromSuperview];
    } completion:^(BOOL finished) {
        
    }];
}
-(void)showShadowView
{
    [UIView animateWithDuration:0.3 animations:^{
        _showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.tableView.scrollEnabled = NO;
        
    } completion:^(BOOL finished) {
        _pickerView.frame = CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200);
    }];
}

/**
 *  三天，自定义时间tableView的show，hide
 */
- (void)hiddenMaskView:(UITapGestureRecognizer *)reg
{
    [UIView animateWithDuration:0.1 animations:^{
        _maskView.frame = CGRectMake(0, 40, self.view.frame.size.width, 1);
        [self.headerView.moreBtn setImage:[UIImage imageNamed: @"Bootm"] forState:UIControlStateNormal];
        self.tableView.scrollEnabled = YES;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _TableView.frame = CGRectMake(0, 40, self.view.frame.size.width, 1);
            
            [self.tableView reloadData];
        }];
    }];
}
- (void)showMaskView
{
    [UIView animateWithDuration:0.1 animations:^{
        _maskView.frame = CGRectMake(0, 40, self.view.frame.size.width, 700);
        self.tableView.scrollEnabled = NO;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _TableView.frame = CGRectMake(0, 40, self.view.frame.size.width, 150);
        }];
    }];
}
#pragma mark ==============life Cycle ===========
- (void)viewDidLoad {
    [super viewDidLoad];
    _modelArr = [[NSMutableArray alloc]init];
    _status = @" ";
    _startTime = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
    _endTime =@"";
    self.title = @"交易管理";
    if (App_User_Info.myInfo.userModel.defaultBusiness.length != 0) {
        [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%ld",(long)_pageNum]];
    }
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 header ");
        [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_startTime currentPageNum:[NSString stringWithFormat:@"%d",0]];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 footer");
        _pageNum ++;
        [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%ld",(long)_pageNum]];
    }];
    self.tableView.showsVerticalScrollIndicator = NO;
    
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    if (App_User_Info.myInfo.user.business_bound.length != 0) {
//        [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
//    }
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag != 10086) {
        
        __weak typeof(self) weakSelf = self;
        
        if (_dateView ==nil)
        {
            _dateView = [[DateView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
            _dateView.style = 0;
        }
        
        typeof(DateView *)safeDateView = _dateView;
#pragma mark ----- 点击圆圈日期的回调 -----
        _dateView.dayBtnClick = ^(NSString * timeStr)
        {
            weakSelf.startTime = timeStr;
            weakSelf.endTime = @"";
            weakSelf.pageNum = 0;
            [weakSelf.modelArr removeAllObjects];
            [weakSelf getOrderListByBusinessIdDateStatuUrlRequestStartTime:weakSelf.startTime endTime:weakSelf.endTime status:_status currentPageNum:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNum]];
        };
#pragma mark ----自定义时间 ----
        _dateView.BtnBlock = ^(StartEndView * startEndView,TIMETYPE type)
        {
//            [weakSelf.showView removeFromSuperview];
            weakSelf.showView = nil;
            if (weakSelf.showView == nil) {
                weakSelf.showView = [[UIView alloc]initWithFrame:CGRectMake(0, weakSelf.view.frame.size.height, weakSelf.view.frame.size.width, 1)];
                weakSelf.showView.backgroundColor = [UIColor grayColor];
                weakSelf.showView.alpha = 0.5;
                [weakSelf.view addSubview:weakSelf.showView];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(hiddenShadowView:)];
                [weakSelf.showView addGestureRecognizer:tap];
                
                self.pickerView =[[[NSBundle mainBundle]loadNibNamed:@"DatePickerView" owner:nil options:nil]lastObject];
                weakSelf.pickerView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
                switch (type) {
                    case TIMETYPE_START:
                    {
                        weakSelf.pickerView.titleLab.text = @"起始时间";
                        weakSelf.pickerView.CancleAndDoneBlock = ^(DatePickerView * pickerView,NSString * selectedDateStr,NSString * date){
                            if (selectedDateStr) {
                                FMLog(@"%@",selectedDateStr);
                                [safeDateView.startAndEndTimeView.startTime setTitle:selectedDateStr forState:UIControlStateNormal];
                                _startTime = date;
                                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
                                [weakSelf hiddenShadowView:nil];
                            }
                            [weakSelf hiddenShadowView:nil];
                            
                        };
                    }
                        break;
                    case TIMETYPE_END:
                    {
                        weakSelf.pickerView.titleLab.text = @"截止时间";
                        weakSelf.pickerView.CancleAndDoneBlock = ^(DatePickerView * pickerView,NSString * selectedDateStr,NSString * date){
                            if (selectedDateStr) {
                                [safeDateView.startAndEndTimeView.endTime setTitle:selectedDateStr forState:UIControlStateNormal];
                                _endTime = date;
                                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
                                [weakSelf hiddenShadowView:nil];
                            }
                            [weakSelf hiddenShadowView:nil];
                            
                        };
                    }
                        break;
                    default:
                        break;
                }
                
                
                [weakSelf.view addSubview:weakSelf.pickerView];
                
            }
            [weakSelf showShadowView];
            
        };
        
        /**
         *  子表和蒙板（点击更多，showAnimation）
         */
        _dateView.maskViewAnimation = ^(HeaderView * header,BOOL isTap)
        {
            weakSelf.headerView = header;
            if (_maskView == nil)
            {
                weakSelf.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, weakSelf.view.frame.size.width, 1)];
                weakSelf.maskView.backgroundColor = [UIColor grayColor];
                weakSelf.maskView.alpha = 0.5;
                [weakSelf.view addSubview:weakSelf.maskView];
                
                weakSelf.TableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 40, weakSelf.maskView.frame.size.width, 1) style:UITableViewStyleGrouped];
                weakSelf.TableView.tag = 10086;
                weakSelf.TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                weakSelf.TableView.delegate = weakSelf;
                weakSelf.TableView.dataSource = weakSelf;
                [weakSelf.view addSubview:weakSelf.TableView];
                
                weakSelf.maskView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(hiddenMaskView:)];
                [weakSelf.maskView addGestureRecognizer:tap];
            }
            if (isTap) {
                 [weakSelf showMaskView];
            }else
            {
                [weakSelf hiddenMaskView:nil];
            }
           
        };
        return _dateView;
    }
    else
    {
        return nil;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 10086) {
        NSArray * nameArr = @[@"今天",@"三天内",@"一周内",@"一个月内",@"自定义时间"];
        DateClickCell * cell = [tableView dequeueReusableCellWithIdentifier:@"click"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DateClickCell" owner:self options:nil]lastObject];
        }
        cell.contentLab.text =nameArr[indexPath.row];
        if (_selectRow != indexPath.row) {
            cell.isRed = NO;
        }else
        {
            cell.isRed = YES;
        }
        return cell;
    }else
    {
        if (indexPath.row == 0) {
            TMButtonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TMButtonCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TMButtonCell" owner:self options:nil]lastObject];
            }
#pragma mark --------点击Status Button的回调事件 --------
            cell.buttonClickBlock = ^(NSInteger tag){
                _pageNum = 0;
                if (tag ==0) {
                    _status = @" ";
                }else
                {
                    _status = [NSString stringWithFormat:@"%ld",(long)tag];
                }
                [_modelArr removeAllObjects];
                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%ld",(long)_pageNum]];
                
            };
            return cell;
        }else
        {
            TMStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TMStatusCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TMStatusCell" owner:self options:nil]lastObject];
            }
            OrderListModel * model = _modelArr[indexPath.row-1];
            cell.topLab.text = model.order_id;
            cell.timeLab.text = model.createTime;
            if (model.price == NULL) {
                cell.moneyLab.text = [NSString stringWithFormat:@"%.2f",model.amount];
            }else
            {
                cell.moneyLab.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
            }
            return cell;
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 10086) {
        return 5;
    }
    return _modelArr.count +1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 10086)
    {
        /**
         *  漏逻辑
         */
        DateClickCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isRed = YES;
        
        _selectRow = indexPath.row;
        switch (indexPath.row)
        {
            case 0:
            {
                _dateView.headerView.leftBtn.hidden = NO;
                _dateView.dateStr = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
                _dateView.headerView.btnClickNum = 0;
                _dateView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
                _dateView.headerView.btnClickNum = 0;
                _dateView.style = 0;
                _startTime = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
                _endTime = @"";
                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
                
            }
                
                break;
            case 1:{//三天
                
                _dateView.dateStr = [NSString stringWithFormat:@"%@至%@",[[NSDate dateWithDaysBeforeNow:2] toStringWithFormat:@"yyyy-MM-dd"],[[NSDate date] toStringWithFormat:@"yyyy-MM-dd"]];
                _dateView.style = 1;
                _dateView.headerView.leftBtn.hidden = YES;
                _startTime =[[NSDate dateWithDaysBeforeNow:2] toStringWithFormat:@"yyyy-MM-dd"];
                _endTime = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
            }
                break;
            case 2:{//一周
                
                _dateView.dateStr = [NSString stringWithFormat:@"%@至%@",[[NSDate dateWithDaysBeforeNow:6] toStringWithFormat:@"yyyy-MM-dd"],[[NSDate date] toStringWithFormat:@"yyyy-MM-dd"]];
                _dateView.style = 1;
                _dateView.headerView.leftBtn.hidden = YES;
                _startTime = [[NSDate dateWithDaysBeforeNow:6] toStringWithFormat:@"yyyy-MM-dd"];
                _endTime = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
            }
                break;
            case 3:{//yue
                
                _dateView.dateStr = [NSString stringWithFormat:@"%@至%@",[[NSDate dateWithDaysBeforeNow:30] toStringWithFormat:@"yyyy-MM-dd"],[[NSDate date] toStringWithFormat:@"yyyy-MM-dd"]];
                _dateView.style = 1;
                _dateView.headerView.leftBtn.hidden = YES;
                
                _startTime = [[NSDate dateWithDaysBeforeNow:30] toStringWithFormat:@"yyyy-MM-dd"];
                _endTime = [[NSDate date] toStringWithFormat:@"yyyy-MM-dd"];
                [self getOrderListByBusinessIdDateStatuUrlRequestStartTime:_startTime endTime:_endTime status:_status currentPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
            }
                break;
            case 4:
            {
                _dateView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
                _dateView.style = 2;
                _dateView.dateStr = @"自定义时间";
                _dateView.headerView.leftBtn.hidden = YES;
            }
                break;
                
            default:
            {
                
            }
                break;
        }
        
        [self hiddenMaskView:nil];
        [tableView reloadData];
    }
    else
    {
        if (indexPath.row != 0) {
            UIStoryboard * SB = [UIStoryboard storyboardWithName:@"OrderDetailTVC" bundle:nil];
            OrderDetailTVC * orderTVC = [SB instantiateInitialViewController];
            OrderListModel * model = _modelArr[indexPath.row-1];
            orderTVC.orderId = model.order_id;
            orderTVC.type = model.status;
            [self.navigationController pushViewController:orderTVC animated:YES];
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10086) {
        return 30;
    }else
    {
        if (indexPath.row == 0) {
            return 75;
        }
        return 70;
    }
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 10086)
    {
        return 0.01;
    }
    else
    {
        switch (_dateView.style)
        {
            case 0:
                return 90;
                
            case 1:
                return 50;
                
            case 2:
                return 140;
            default:
                break;
        }
    }
}





-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

@end
