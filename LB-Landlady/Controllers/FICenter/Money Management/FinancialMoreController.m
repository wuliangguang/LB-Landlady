//
//  FinancialMoreController.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/9/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "FinancialMoreController.h"

@interface FinancialMoreController ()

@property (nonatomic) NSMutableArray *dataArray;
@end

@implementation FinancialMoreController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initModel];
}

- (void)initUI {
    self.clearsSelectionOnViewWillAppear = YES;
    self.title = @"更多";
}

- (void)initModel {
    self.dataArray = [NSMutableArray arrayWithObjects:@"了解老板娘理财", @"理财产品资金转变流程", @"意见反馈", nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.font   = LK_FONT_SIZE_TWO;
    cell.textLabel.text   = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
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
