//
//  OrderQueryViewController.m
//  ZBL
//
//  Created by 张伯林 on 16/3/31.
//  Copyright © 2016年 张伯林. All rights reserved.
//

#import "OrderQueryViewController.h"
#import "OrderQueryCell.h"
#import <CommonCrypto/CommonDigest.h>
#import "OrserQueryModel.h"
#import "NSString+Helper.h"
@interface OrderQueryViewController ()
@property(nonatomic)NSMutableArray *dataArray;
@property (nonatomic)NSInteger pageNum;
@end

@implementation OrderQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.dataArray = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderQueryCell class]) bundle:nil] forCellReuseIdentifier:@"OrderQueryCellId"];
    //self.tableView.tableFooterView = [[UIView alloc]init];
    [self downAndParsingDataModel:_pageNum];
    self.tableView.separatorStyle = NO;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 header ");
        _pageNum = 0;
        [self downAndParsingDataModel:_pageNum];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        FMLog(@"交易管理列表刷新 footer");
        _pageNum ++;
        [self downAndParsingDataModel:_pageNum];
    }];

    
}
- (void)downAndParsingDataModel:(NSInteger)pageNumber{
    NSString *businessId = App_User_Info.myInfo.userModel.defaultBusiness;
    //NSString *userId = @"222";
    NSString *currentPageNum = [NSString stringWithFormat:@"%ld",pageNumber];
    NSString *pageSize = @"20";
    NSString *key = @"a1b909ec1cc11cce40c28d3640eab600e582f833";
    NSString *status= @"success";
    NSDictionary *parms;
    if ([self.string isEqualToString:@"orderDetailButtonClock"]) {
        
       NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",businessId,currentPageNum,pageSize,key];
        sign = [sign mdd5];
        parms = @{@"businessId":businessId,@"currentPageNum":currentPageNum,@"pageSize":pageSize,@"sign":sign};
    }else if ([self.string isEqualToString:@"incomeDetailButtonClock"]){
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",businessId,currentPageNum,pageSize,status,key];
        sign = [sign mdd5];
        parms = @{@"businessId":businessId,@"currentPageNum":currentPageNum,@"pageSize":pageSize,@"status":status,@"sign":sign};
    }
    
    [S_R LB_PostWithURLString:[URLService getOfflineCountByBusinessUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"----responseObject:%@-----responseString:%@",responseObject,responseString);
        if ([currentPageNum isEqualToString:@"0"]) {
            [self.dataArray removeAllObjects];
        }
        NSArray *orderList = ((NSDictionary *)responseObject)[@"data"];
        for (NSDictionary *dict in orderList) {
            OrserQueryModel *model = [[OrserQueryModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        
    } WithController:self];
   // NSLog(@"------%@",sign);
}//f73b69e2d47b787220f9ec59f9877514
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)md5Encrypt:(NSString *)str {
    const char *original_str = [str UTF8String];
    unsigned char result[16];
    
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    
    
    
    CC_MD5( cStr, strlen(cStr), result );
    
    
    
    return [NSString stringWithFormat:
            
            
            
            @"xxxxxxxxxxxxxxxx",
            
            
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"------self.dataArray.count:%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.dataArray.count < indexPath.row) {
//        return nil;
//    }
    OrderQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderQueryCellId"];
    OrserQueryModel *model = self.dataArray[indexPath.row];
//    cell.layer.masksToBounds = YES;
//    cell.layer.cornerRadius = 20;
//    cell.backgroundColor = [UIColor orangeColor];
    [cell showAndUpdateModel:model];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
