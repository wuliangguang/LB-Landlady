//
//  IncomeOnlineViewController.m
//  MeZoneB_Bate
//
//  Created by d2space on 15/9/21.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "IncomeOnlineViewController.h"
#import "TableViewMainHeader.h"
#import "TableViewSubHeader.h"
#import "IncomOnlineCell.h"
#import "MJRefresh.h"
//#import "MarketDetail.h"
//#import "MarketSummary.h"

@interface IncomeOnlineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL            has_Next;
@property (nonatomic, assign) BOOL            isSelectedMoreBtn;
@property (nonatomic, assign) NSInteger       pageCount;
@property (nonatomic, strong) NSMutableArray  *incomes;                    //收入列表数据
@property (nonatomic, strong) NSArray         *incomeStatisticals;         //收入统计数据
//@property (nonatomic, strong) MarketSummary   *summary;
@end

@implementation IncomeOnlineViewController
#pragma mark *********************** ViewController Life Cycle ********************
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.incomeType == INCOME_ONLINE)
    {
        self.title = @"在线收入";
    }
    else if (self.incomeType == INCOME_STORE)
    {
        self.title = @"到店收入";
    }

    [self initRefresh];
    
    self.pageCount = 1;
    
//    if (self.incomeType == INCOME_COMMISSION || self.incomeType == INCOME_ADVERTISMENT || self.incomeType == INCOME_ROUTER)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.tableView.hidden = YES;
//            
//            UIImageView *constructionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 55, kScreenHeight/2 -29, 164, 140)];
//            constructionImageView.image = [UIImage imageNamed:@"lihe"];
//            constructionImageView.center = self.view.center;
//            [self.view addSubview:constructionImageView];
//        });
//    }
//    if (self.incomeType == INCOME_CHANGECASH) {
//        [self performSegueWithIdentifier:@"noBind" sender:nil];
//    }
//    [self getTodayTotalIncome];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark *********************** Initialization ********************
- (void)initRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReresh)];
    self.tableView.footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerReresh)];
}
//下拉
- (void)headerReresh
{
    self.pageCount = 1;
    [self.tableView.header endRefreshing];
}

//上拉
- (void)footerReresh
{
    if (self.has_Next)
    {
        self.pageCount++;
//        [self getIncomeWithType];
        [self.tableView.footer endRefreshing];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"数据已全部加载！";
            [hud hide:YES afterDelay:SUCCESSFUL_DELAY];
            [self.tableView.footer endRefreshing];
        });
    }
}

#pragma mark *********************** Btn Method ********************

#pragma mark *********************** TableView DataSource ********************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.isSelectedMoreBtn == NO)
        {
            return 0;
        }
        return _incomeStatisticals.count;
    }
    else
    {
        return _incomes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView && indexPath.section == 0)
    {
        static NSString *identify = @"identify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 21)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 21, kScreenWidth, 59)];
        priceLabel.textColor = [HEXColor getColor:@"fd8307"];
        priceLabel.font = [UIFont systemFontOfSize:40];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:priceLabel];
        
        if (indexPath.row == 0)
        {
            titleLabel.text = @"当月收入（元）";
        }
        else if(indexPath.row == 1)
        {
            titleLabel.text = @"当年收入（元）";
        }
        
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
        [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *doubleStr = [NSString stringWithFormat:@"%.2f",[self.incomeStatisticals[indexPath.row] doubleValue]];
        NSString *priceStr = [numFormatter stringFromNumber:[NSNumber numberWithDouble:[doubleStr doubleValue]]];
        priceLabel.text  = [NSString stringWithFormat:@"%@",priceStr];
        return cell;
    }
    else
    {
        IncomOnlineCell *cell = (IncomOnlineCell *)[tableView dequeueReusableCellWithIdentifier:@"incom"];
        if (cell == nil)
        {
            cell = (IncomOnlineCell *)[[IncomOnlineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        }
        for (UILabel *label in cell.contentView.subviews)
        {
            if (label.tag == 1200)
            {
                [label removeFromSuperview];
            }
        }
        
//        MarketDetail *md = self.incomes[indexPath.row];
        
        UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 150, 0, 134, 60)];
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = [HEXColor getColor:@"fe3e26"];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.tag = 1200;
        [cell.contentView addSubview:rightLabel];
        
        cell.textLabel.textColor = [HEXColor getColor:@"252525"];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
//        cell.textLabel.text = [NSString stringWithFormat:@"订单编号：%@",md.sn];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
//        cell.detailTextLabel.text = md.create_time;
        cell.detailTextLabel.textColor = [HEXColor getColor:@"b4b4b4"];
        
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"+ %.1f",[md.price doubleValue]]];
//        [str addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:20]
//                    range:NSMakeRange(1, [str length]-2)];
//        rightLabel.attributedText = str;
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 59, kScreenWidth - 20, 1)];
        lineLabel.backgroundColor = Color(235, 235, 235);
        [cell.contentView addSubview:lineLabel];
        
        return cell;
    }
}

#pragma mark *********************** TableView Delegate ********************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.incomeType == INCOME_ONLINE || self.incomeType == INCOME_STORE)
    {
        if (indexPath.section == 0)
        {
            return 80;
        }
        return 60;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.incomeType == INCOME_ONLINE || self.incomeType == INCOME_STORE||self.incomeType == INCOME_BANKCARD)
    {
        if (section == 0)
        {
            if (self.incomeStatisticals.count > 0)
            {
                return (kScreenWidth/5)*2+40;
            }
            return (kScreenWidth/5)*2;
        }
        else if (section == 1)
        {
            if (self.incomes.count > 0)
            {
                return 50;
            }
            return 10;
        }
        return 0.2;
    }
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.incomeType == INCOME_ONLINE || self.incomeType == INCOME_STORE||self.incomeType == INCOME_BANKCARD)
    {
        NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"MarketDetailMainHeader" owner:self options:nil];
        if (section == 0)
        {
            TableViewMainHeader *headerView = nil;
            if (views.count > 1)
            {
                headerView = views[1];
                headerView.frame = CGRectMake(0, 0,kScreenWidth , (kScreenWidth/5)*2);
                UIImageView *textLeftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 13, 13)];
                textLeftView.image = [UIImage imageNamed:@"Safe_Account_Icon"];
                headerView.noticeLabel.leftView = textLeftView;
                headerView.noticeLabel.leftViewMode = UITextFieldViewModeAlways;
                
//                if (self.summary.day)
//                {
//                    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
//                    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//                    NSString *doubleStr = [NSString stringWithFormat:@"%.2f",self.summary.day.doubleValue];
//                    NSString *priceStr = [numFormatter stringFromNumber:[NSNumber numberWithDouble:[doubleStr doubleValue]]];
//                    headerView.priceLabel.text = [NSString stringWithFormat:@"%@",priceStr];
//                }

                if (self.incomeStatisticals.count > 0)
                {
                    headerView.moreBtn.hidden = NO;
                    [headerView.moreBtn setImage:[UIImage imageNamed:@"statusImage"] forState:UIControlStateNormal];
                    if (self.isSelectedMoreBtn == YES)
                    {
                        [UIView animateWithDuration:1 animations:^{
                            CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI);
                            headerView.moreBtn.imageView.transform = rotate;
                        }];
                    }
                    else
                    {
                        [UIView animateWithDuration:1 animations:^{
                            CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI*2);
                            headerView.moreBtn.imageView.transform = rotate;
                        }];
                    }
                    
                    headerView.clickMoreBtn = ^(UIButton *btn)
                    {
                        self.isSelectedMoreBtn = !self.isSelectedMoreBtn;
                        if (self.isSelectedMoreBtn == YES)
                        {
                            [UIView animateWithDuration:1 animations:^{
                                CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI);
                                btn.imageView.transform = rotate;
                                btn.imageView.backgroundColor = [UIColor whiteColor];
                            }];
                        }
                        else
                        {
                            [UIView animateWithDuration:1 animations:^{
                                CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI*2);
                                btn.imageView.transform = rotate;
                                btn.imageView.backgroundColor = [UIColor whiteColor];
                            }];
                        }
                        [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:1];
                    };
                }
                else
                {
                    headerView.moreBtn.hidden = YES;
                }
                return headerView;
            }
            else
            {
                return nil;
            }
        }
        else if (section == 1)
        {
            if (self.incomes.count > 0)
            {
                TableViewSubHeader *headerView = nil;
                if (views.count > 2)
                {
                    headerView = views[2];
                    headerView.backgroundColor = Color(235, 235, 235);
                    return headerView;
                }
                return nil;
            }
            return nil;
            
        }
    }
    return nil;
}
- (void)reloadTableView
{
    [self.tableView reloadData];
}
#pragma mark *********************** Interface Part ********************
//- (void)getIncomeWithType
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSString *pathStr = nil;
//        if (self.incomeType == INCOME_ONLINE)
//        {
//            pathStr = [URLService getMarketDetailListURL];
//        }
//        else if (self.incomeType == INCOME_STORE)
//        {
//            pathStr = [URLService getToShopIncomeDetailListURL];
//        }
//        else
//        {
//            return;
//        }
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        [params setObject:[NSNumber numberWithInteger:self.pageCount] forKey:@"page"];
//        [NET_REQUEST MeZoneGetWithURLString:pathStr WithParams:params WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//             if ([responseObject[@"status"] integerValue] == 0)
//             {
//                 self.has_Next = [responseObject[@"has_next"] boolValue];
//                 if (self.pageCount == 1)
//                 {
//                     self.incomes = [NSMutableArray array];
//                 }
//                 NSArray *items = [MarketDetail objectArrayWithKeyValuesArray:responseObject[@"result"][@"items"]];
//                 if (items.count > 0)
//                 {
//                     for (int i =0; i < items.count; i ++)
//                     {
//                         MarketDetail *md = items[i];
//                         [self.incomes addObject:md];
//                     }
//                 }
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     [self.tableView reloadData];
//                 });
//             }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        } WithController:self];
//    });
//}
//
//- (void)getTodayTotalIncome
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSString *pathStr = nil;
//        if (self.incomeType == INCOME_ONLINE)
//        {
//            pathStr = [URLService getMarketSummaryURL];
//        }
//        else if (self.incomeType == INCOME_STORE)
//        {
//            pathStr = [URLService getToShopIncomeSummaryURL];
//        }
//        else
//        {
//            return ;
//        }
//        [NET_REQUEST MeZoneGetWithURLString:pathStr WithParams:nil WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            if ([responseObject[@"status"] integerValue] == 0)
//            {
//                self.summary = [MarketSummary objectWithKeyValues:responseObject[@"result"]];
//                self.incomeStatisticals = @[self.summary.month,self.summary.year];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
//                });
//                [self getIncomeWithType];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        } WithController:self];
//    });
//}
@end
