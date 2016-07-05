//
//  WaiterManagerViewController.m
//  MeZoneB_Bate
//
//  Created by 李宝宝 on 15/11/23.
//  Copyright © 2015年 Lianbi. All rights reserved.
//

#import "WaiterManagerViewController.h"
#import "WaiterListCell.h"
//#import "WaiterListModel.h"
#import <UIImageView+WebCache.h>
#import "PinYin4Objc.h"
#import "WaiterInfoTableVC.h"
#import "NSObject+Helper.h"
#import "CommonModel.h"
#import "WaiterListModel.h"

@interface WaiterManagerViewController ()
{
    NSMutableArray *_resultArray;/**<搜索结果数组*/

}

@property(nonatomic,strong)UISearchDisplayController * searchController;
@property (nonatomic,strong) NSMutableArray *waiterListArr; /**<全部服务员数组*/
@property (nonatomic) NSMutableArray *sortedArray; // 排序后的数组 [arr1, arr2, arr3 ...] 对应一个个section

@property(nonatomic,strong)NSMutableArray *sectionArr;/**<右边索引数组*/
@property(nonatomic,strong)NSMutableArray *letterResultArr;
// @property(nonatomic,strong)NSNumber * deleteIDNum;
@property(nonatomic,strong)MBProgressHUD * Mbp;
@property(nonatomic,strong)MBProgressHUD * progressView;
// @property (nonatomic) NSIndexPath *choosedIndexPath;
@end

@implementation WaiterManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员管理";
    [self acquireStoreWaiterList];
    _resultArray = [[NSMutableArray alloc]initWithCapacity:0];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _searchBar.placeholder = @"搜索人员名字";
    [_searchBar sizeToFit];
    [self.view addSubview: _searchBar];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];
    self.tableView.rowHeight = 60;
    self.tableView.bounces = NO;
    
    
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = LD_COLOR_FOURTEEN;
    _tableView.sectionIndexColor = [UIColor blackColor];
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    self.searchController.searchResultsTableView.rowHeight = 60;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    self.searchController.searchResultsTableView.rowHeight = 60;
    self.searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.searchController.searchResultsTableView.backgroundColor = LD_COLOR_FOURTEEN;
    self.tableView.tableHeaderView = _searchBar;

    _progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

#pragma mark ------tableViewDelegate ----
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView]) {
        NSMutableArray * existTitles = [NSMutableArray array];
        //section数组为空的title过滤掉，不显示
        if (self.sortedArray.count!=0) {
            for (int i = 0; i < [self.sectionArr count]; i++) {
                if ([[self.sortedArray objectAtIndex:i] count] > 0) {
                    [existTitles addObject:[self.sectionArr objectAtIndex:i]];
                }
            }
        }
        return existTitles;
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*
     NSArray * arr = [NSArray arrayWithObject:model.name];
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",_searchController.searchBar.text];
     _resultArray =  [[NSArray alloc] initWithArray:[arr filteredArrayUsingPredicate:predicate]];
     */
    if ([tableView isEqual:self.tableView]) {
        return [_sortedArray[section] count];
    } else {
        return _resultArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView]) {
        return _sortedArray.count;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    for (UIView * subview in self.tableView.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
            [subview setBackgroundColor:[UIColor whiteColor]];
        }
    }
    WaiterListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WaiterListCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WaiterListModel * model = nil;
    if ([tableView isEqual:self.tableView]) {
        model = _sortedArray[indexPath.section][indexPath.row];
    } else {
        model = _resultArray[indexPath.row];
    }
    [cell.avater sd_setImageWithURL:[NSURL URLWithString:model.salesclerk_image] placeholderImage:[UIImage imageNamed:@"default_1_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image)
        {
            cell.avater.image = image;
        }
    }];
//    if (model.salesclerk_image) {
//        cell.avater.image = [UIImage imageNamed:model.salesclerk_image];
//    } else {
//        [cell.avater sd_setImageWithURL:[NSURL URLWithString:model.salesclerk_image] placeholderImage:[UIImage imageNamed:@"defultheadimage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (image)
//            {
//                cell.avater.image = image;
//            }
//        }];
//    }
    
    cell.nameLabel.text     = model.salesclerk_name;
    cell.positionLabel.text = model.salesclerk_job;
    cell.phoneLabel.text    = model.salesclerk_phone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (![tableView isEqual:self.tableView]||[[self.sortedArray objectAtIndex:section] count] == 0) {
        return 0.01;
    }else
    {
        return 17;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchController.searchResultsTableView]){
        return nil;
    } else if ([[self.sortedArray objectAtIndex:section] count] == 0) {
        return nil;
    } else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 22)];
        label.backgroundColor = [HEXColor getColor:@"#ededed"];
        [label setText:[NSString stringWithFormat:@"  %@",[self.sectionArr objectAtIndex:section]]];
        label.textColor = Color(38, 38, 38);
        label.font = [UIFont systemFontOfSize:14];
        return label;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaiterListModel * model = nil;
    if ([tableView isEqual:self.tableView]) {
        model = _sortedArray[indexPath.section][indexPath.row];
    } else {
        model = _resultArray[indexPath.row];
    }
    // self.choosedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"info" sender:model];
}

// 跳转  新增/点击cell
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"info"]) { // 点击cell，查看店员信息并可以修改店员信息
        WaiterInfoTableVC *infoVC = segue.destinationViewController;
        infoVC.model = sender;
        [infoVC setCallbackHandler:^(WaiterListModel *model) { // 修改店员
            [self sortAndrefresh];
            
            // [self.tableView reloadData];
        }];
    } else { // 新增店员
        NSLog(@"%@", [segue.destinationViewController class]); // ChangeInfoTableVC
        // 新增店员 ChangeInfoTableVC
        ChangeInfoTableVC *changeVC = segue.destinationViewController;
        [changeVC setCallbackHandler:^(WaiterListModel *model) {
            // 这里传过来的model既使不为空也不能用，因为我们要知道model的id, 删除的时候要用到这个id, 而这个id是服务器给的，故，重新请求：
            [self acquireStoreWaiterList];
        }];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
 - (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
     return UITableViewCellEditingStyleDelete;
 }
 -(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
     return @"删除";
 }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否删除该店员?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        WaiterListModel *model = self.sortedArray[indexPath.section][indexPath.row];
        alert.attachObject = model;
    }
}

#pragma mark ------UIAlertViewDelegate ----
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
#warning 删除店员刷新数据，数据库网络请求
        [self deleteWaiter:alertView.attachObject];
    }
}

// 删除Waiter
-(void)deleteWaiter:(WaiterListModel *)waiter
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getDelSalesclerkUrl];
        NSMutableArray * array = [[NSMutableArray alloc]init];
        [array addObject:[NSNumber numberWithInteger:waiter.salesclerk_id]];
        NSString * arrStr = [NSString getStringFromArray:array];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:arrStr forKey:@"alesclerkId"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSString * mes = nil;
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                [self.waiterListArr removeObject:waiter];
                [self sortAndrefresh];
                mes = @"删除成功";
                // [self.tableView reloadData];
            } else {
                mes = @"删除失败";
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _Mbp.mode = MBProgressHUDModeText;
                _Mbp.labelText = mes;
                [_Mbp hide:YES afterDelay:2];
            });

        } failure:^(NSError *error) {
            FMLog(@"delete ------ error %@",error);
        } WithController:self];
    });
}


#pragma mark - UISearchDisplayDelegate
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"11---%@----%@----%ld",searchString,[_searchBar scopeButtonTitles][_searchBar.selectedScopeButtonIndex],_searchBar.selectedScopeButtonIndex);
    [self filterContentForSearchText:searchString scope:[_searchBar scopeButtonTitles][_searchBar.selectedScopeButtonIndex]];
    return YES;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSLog(@"22---%@----%@---%ld",_searchBar.text,_searchBar.scopeButtonTitles[searchOption],searchOption);
    [self filterContentForSearchText:_searchBar.text scope:_searchBar.scopeButtonTitles[searchOption]];
    return YES;
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scopec
{
    [_resultArray removeAllObjects];
    if (searchText.length>0&&![ChineseInclude isIncludeChineseInString:searchText])
    {
        for (int i=0; i<_sortedArray.count; i++)
        {
            for (int j=0; j<[_sortedArray[i] count]; j++) {
                WaiterListModel * model =_sortedArray[i][j];
                NSString * name = model.salesclerk_name;
                if ([ChineseInclude isIncludeChineseInString:name])
                {
                    NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:name];
                    NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0)
                    {
                        [_resultArray addObject:_sortedArray[i][j]];
                    }
                }
                else
                {
                    NSRange titleResult=[name rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0)
                    {
                        [_resultArray addObject:_sortedArray[i][j]];
                    }
                }
            }
            
        }
    }
    else if (searchText.length>0&&[ChineseInclude isIncludeChineseInString:searchText])
    {
        
        for (NSArray *sub in _sortedArray) {
            for (WaiterListModel *model in sub)
            {
                NSRange titleResult=[model.salesclerk_name rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0)
                {
                    [_resultArray addObject:model];
                }
            }
        }
    }
    
}

/**
 *  刷新表格
 *  新增店员后为了不重新请求数据，把新增的店员加入_waiterListArr中，需要重新根据新增的店员重新排版表格
 */
- (void)sortAndrefresh {
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    self.sectionArr = [NSMutableArray arrayWithCapacity:0];
    [self.sectionArr addObjectsFromArray:[indexCollation sectionTitles]]; // 右侧索引
    NSInteger highSection = [self.sectionArr count];
    
    //tableView 会被分成highSection个section
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    //名字分section
    for (WaiterListModel * model in _waiterListArr) {
        NSString * name = model.salesclerk_name;
        
        NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:name];
        NSInteger section = [indexCollation sectionForObject:[tempPinYinStr substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        
        ///添加人
        [array addObject:model];
    }
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(WaiterListModel *obj1, WaiterListModel *obj2) {
            NSString *name1 = [[[PinYinForObjc chineseConvertToPinYin:obj1.salesclerk_name] substringToIndex:1] uppercaseString];
            NSString *name2 = [[[PinYinForObjc chineseConvertToPinYin:obj2.salesclerk_name] substringToIndex:1] uppercaseString];
            return [name1 caseInsensitiveCompare:name2];
        }];
    
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    self.sortedArray = sortedArray;
    [self.tableView reloadData];
}

#pragma mark ------NetRequest-------
-(void)acquireStoreWaiterList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        FMLog(@"%@",App_User_Info.myInfo.userModel.defaultBusiness);
        [params setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
        NSString * urlStr = [URLService getSalesclerkListByBusinessUrl];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseString dataClass:nil];
            NSArray *array = [WaiterListModel mj_objectArrayWithKeyValuesArray:commonModel.data[@"salesclerkList"]];
            self.waiterListArr = [[NSMutableArray alloc]initWithArray:array];;
            [self sortAndrefresh];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_progressView hide:YES];
            });
            FMLog(@"responseObject ==  %@",responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSLog(@"%@", responseObject);
            }
        } failure:^(NSError *error) {
            FMLog(@"error  ==  %@",error);
        } WithController:self];
    });
}

@end
