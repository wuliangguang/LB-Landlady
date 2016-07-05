//
//  CurrentFinancialController.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/9/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "CurrentFinancialController.h"
#import "GM_ADCell.h"
#import "FinancialProductCell.h"
#import "UITableView+ZZHiddenExtraLine.h"
//#import "LBFinancialProductModel.h"

@interface CurrentFinancialController ()

//@property (nonatomic) LBFinancialProductModel *productModel;
@end

@implementation CurrentFinancialController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.clearsSelectionOnViewWillAppear = NO;
    [self initUI];
    
//    [self fetchWebData];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FinancialProductCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FinancialProductCell class])];
    [self.tableView hiddenExtraLine];
    self.title = @"活期理财";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return section == 0 ? 1 : self.productModel.result.count;
    return 10;
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

@end
