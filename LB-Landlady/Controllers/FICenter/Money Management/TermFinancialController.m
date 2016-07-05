//
//  TermFinancialController.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/9/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "TermFinancialController.h"
#import "GM_ADCell.h"
#import "FinancialProductCell.h"
//#import "UITableView+ZZHiddenExtraLine.h"
#import "BuyFinancialProductController.h"
//#import "LBFinancialProductModel.h"

@interface TermFinancialController ()

//@property (nonatomic) LBFinancialProductModel *productModel;
@end

@implementation TermFinancialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];

}

- (void)initUI {
    self.title = @"定期理财";
    
    self.tableView.backgroundColor = LD_COLOR_FOURTEEN;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FinancialProductCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FinancialProductCell class])];
//    [self.tableView hiddenExtraLine];
}

//- (void)fetchWebData {
//    [NET_REQUEST MeZoneGetWithURLString:[URLService currentOrFix] WithParams:@{@"type":@"d"} WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.productModel = [LBFinancialProductModel objectWithKeyValues:responseObject];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error");
//    } WithController:self];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning self.productModel.result.count
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            GM_ADCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GM_ADCell class]) forIndexPath:indexPath];
            cell.placeholderImage = @"FP_AD";
            return cell;
        }
            break;
        case 1: {
            FinancialProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FinancialProductCell class]) forIndexPath:indexPath];
//            cell.model = self.productModel.result[indexPath.row];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 90.0 : 75.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([BuyFinancialProductController class]) bundle:nil];
    BuyFinancialProductController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

@end





