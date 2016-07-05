//
//  MyMerchantCategoryViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/17/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMerchantCategoryViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "UITableView+ZZHiddenExtraLine.h"
#import "MyMerchantCategoryDetailViewController.h"
#import "IndustryDataModel.h"
#import "CommonModel.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface MyMerchantCategoryViewController ()

@property (nonatomic) NSArray *industryArray; // 行业列表数组
@end

@implementation MyMerchantCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self fetchWebData];
}

- (void)fetchWebData {
    /**
     *  行业分类
     */
    NSDate *date = [[NSDate alloc]init];
    
    NSString *serNum = [NSString toUUIDString];
    NSString *source = @"app";
    NSString *reqTime;
    reqTime = [date toString];
    NSArray *rurur = @[
                       @{@"name":@"source",@"detailStr":source},
                       @{@"name":@"serNum",@"detailStr":serNum},
                       @{@"name":@"reqTime",@"detailStr":reqTime}
                       ];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in rurur) {
        SendRequestModel *model = [[SendRequestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    NSString *sign = [SendRequestModel backStrFromeArr:dataArray];
    //NSLog(@"----------------sign:%@",sign);
    NSDictionary *parms = @{@"source":source,@"serNum":serNum,@"reqTime":reqTime,@"sign":sign};
    [S_R LB_GetWithURLString:[URLService getIndustryListUrl] WithParams:parms WithSuccess:^(id responseObject, id responseString) {
         NSLog(@"---------------------------行业分类%@", responseString);
        CommonModel *model = [CommonModel commonModelWithKeyValues:responseObject dataClass:[IndustryDataModel class]];
        if (model.code == SUCCESS_CODE) {
            NSLog(@"成功");
            IndustryDataModel *dataModel = (IndustryDataModel *)model.data;
            self.industryArray = dataModel.modelList;
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showFailToast:@"获取行业列表失败" inView:self.view completionHandler:nil];
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyMerchantCategoryCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyMerchantCategoryCell class])];
    
    self.title = @"行业分类";
    
    UIButton *button = [self addStandardRightButtonWithTitle:@"提交" selector:@selector(submit)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.tableView hiddenExtraLine];
}

- (void)submit {
    IndustryModel *choosedModel = nil;
    for (IndustryModel *model in self.industryArray) {
        if (model.isCheck) {
            choosedModel = model;
            break;
        }
    }
    
    if (choosedModel) {
        if (self.callbackHandler) {
            self.callbackHandler(choosedModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [MBProgressHUD showFailToast:@"请选择行业" inView:self.view completionHandler:nil];
    }
    
    /**
    [self.industryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        IndustryModel *model = (IndustryModel *)obj;
        __weak __typeof(self) weakself = self;
        if (model.isCheck) {
            choosedModel = model;
            if (weakself.callbackHandler) {
                weakself.callbackHandler(model);
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            *stop = YES;
        }
    }];
     */
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.industryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMerchantCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyMerchantCategoryCell class]) forIndexPath:indexPath];
    cell.model = self.industryArray[indexPath.row];
    
    /**
     *  选中button
     */
    /**
    __weak __typeof(self) weakself = self;
    cell.callbackHandler = ^(IndustryModel *model) {
        NSLog(@"TODO:// MyMerchantCategoryViewController cell, callback");
        for (IndustryModel *model in self.industryArray) {
            model.check = NO;
        }
        model.check = YES;
        [weakself.tableView reloadData];
    };
     */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (IndustryModel *model in self.industryArray) {
        model.check = NO;
    }
    IndustryModel *selectModel = self.industryArray[indexPath.row];
    selectModel.check = YES;
    [tableView reloadData];
    
    // 进入货源类别详情，此功能已删除
    // MyMerchantCategoryDetailViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMerchantCategoryDetailViewController class]) bundle:nil] instantiateInitialViewController];
    // [self.navigationController pushViewController:controller animated:YES];
}
@end
