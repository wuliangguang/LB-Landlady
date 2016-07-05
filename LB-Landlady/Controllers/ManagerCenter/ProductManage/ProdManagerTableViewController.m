//
//  ProdManagerTableViewController.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProdManagerTableViewController.h"
#import "ProductAddNewTableViewController.h"
#import "ProductListTableViewController.h"
#import "UITableViewCell+ZZAddLine.h"

@interface ProdManagerTableViewController ()
@property(nonatomic,copy)NSArray *dataArr;
@end

@implementation ProdManagerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"新增商品",@"产品列表",@"微信首页广告设置",@"微信首页产品设置"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.bounces = NO;
//    self.tableView.separatorStyle = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            ProductAddNewTableViewController *addProduct = [[ProductAddNewTableViewController alloc]init];
            addProduct.title = @"新增商品";
            addProduct.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addProduct animated:YES];
        }
            break;
        case 1://ProductListTableViewController
        {
            ProductListTableViewController *productList = [[ProductListTableViewController alloc]init];
            productList.title = @"商品列表";
            productList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:productList animated:YES];
        }
            break;
        case 2:
        {
            MBProgressHUD* mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            mbp.mode = MBProgressHUDModeText;
            mbp.labelText = @"微信首页广告设置";
            [mbp hide:YES afterDelay:1];

        }
            break;
        case 3://@"微信首页广告设置",@"微信首页产品设置"
        {
            MBProgressHUD* mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            mbp.mode = MBProgressHUDModeText;
            mbp.labelText = @"微信首页产品设置";
            [mbp hide:YES afterDelay:1];

        }
            break;
        default:
            break;
    }
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
