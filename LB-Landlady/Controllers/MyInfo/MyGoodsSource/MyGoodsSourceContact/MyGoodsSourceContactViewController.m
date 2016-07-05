//
//  MyGoodsSourceContactViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyGoodsSourceContactViewController.h"
#import "MyGoodsSourceCell.h"
#import "MyGoodsSourceHeadCell.h"
#import "UIViewController+ZZNavigationItem.h"
#import "MyGoodsSourceAddViewController.h"
#import "GoodSourceModel.h"

@interface MyGoodsSourceContactViewController ()
@property(nonatomic,strong)NSMutableArray * contactListArr;
@end

@implementation MyGoodsSourceContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactListArr = [[NSMutableArray alloc]init];
    [self initUI];
}

- (void)initUI {
    self.title = @"联系货源";
    self.tableView.sectionFooterHeight = 0;
    
    UIButton *button = [self addStandardRightButtonWithTitle:@"新增" selector:@selector(addNewGoodsSource)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self fetchWebData];
}
/**
 * * @param	userId		string		用户名
 */
- (void)fetchWebData {
    [S_R LB_GetWithURLString:[URLService getProductSourceContactsUrl] WithParams:@{@"userId" : App_User_Info.myInfo.userModel.userId} WithSuccess:^(id responseObject, id responseString) {
        // NSLog(@"%@", responseString);
        NSArray * array = [GoodSourceModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"contactsList"]];
        self.contactListArr = [NSMutableArray arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

// 联系货源 --> 新增
- (void)addNewGoodsSource {
    MyGoodsSourceAddViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyGoodsSourceAddViewController class]) bundle:nil] instantiateInitialViewController];
    controller.completionHandler = ^(id obj) {
        [self fetchWebData];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contactListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodSourceModel * model = self.contactListArr[indexPath.section];
    if (indexPath.row == 0) {
        MyGoodsSourceHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyGoodsSourceHeadCell class]) forIndexPath:indexPath];
        cell.contactPhone = model.contacts_phone;
        cell.storeNameLab.text = model.contacts_sourceName;
        return cell;
    } else {
        MyGoodsSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyGoodsSourceCell class]) forIndexPath:indexPath];
        cell.dataModel = model;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row % 2 == 0 ? 32.0 : 66.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
