//
//  MyMesageBaseViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/20/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageBaseViewController.h"
#import "UITableView+ZZHiddenExtraLine.h"
#import "UIViewController+ZZNavigationItem.h"
#import "MyMessageDetailViewController.h"
#import "ZZContainerViewController.h"
#import "MyMessageAllViewController.h"
#import "CommonModel.h"

@interface MyMessageBaseViewController ()

@end

@implementation MyMessageBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)initUI {
    self.tableView            = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight  = 60.0f;
    [self.tableView hiddenExtraLine];
    NSString *name = NSStringFromClass([MyMessageCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
    [self.view addSubview:self.tableView];
}

+ (instancetype)viewControllerWithTitle:(NSString *)title {
    MyMessageBaseViewController *controller = [[self alloc] init];
    controller.title = title;
    return controller;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyMessageCell class]) forIndexPath:indexPath];
    MyMessageModel *model = self.dataArray[indexPath.row];
    cell.model            = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMessageDetailViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MyMessageDetailViewController class]) bundle:nil] instantiateInitialViewController];
    __block MyMessageModel *messageModel = self.dataArray[indexPath.row];
    
    // 更新消息为已读
    if (messageModel.is_read == NO) {
        [S_R LB_GetWithURLString:[URLService updateMessageUrl] WithParams:@{@"messageId" : messageModel.message_id} WithSuccess:^(id responseObject, id responseString) {
            CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
            if (commonModel.code == SUCCESS_CODE) {
                messageModel.is_read = YES;
                NSLog(@"%d", [[NSThread currentThread] isMainThread]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    MyMessageAllViewController *controller = self.containerViewController.viewControllers[0];
                    [controller refreshTableView];
                });
            }
            NSLog(@"%@", responseString);
        } failure:^(NSError *error) {
            
        } WithController:self];
    }
    
    controller.messageModel = messageModel;
    controller.callbackHandler = ^(id obj) {
        MyMessageAllViewController *controller = self.containerViewController.viewControllers[0];
        [controller fetchWebData];
        [self.containerViewController.navigationController popViewControllerAnimated:YES];
    };
    ZZContainerViewController *containerController = self.containerViewController;
    [containerController.navigationController pushViewController:controller animated:YES];
}

- (void)didShow {
    self.tableView.frame = self.view.bounds;
}

/** 编辑 */
- (void)edit {
    for (MyMessageModel *model in self.dataArray) {
        model.check   = NO;
        model.editing = YES;
    }
    [self.tableView reloadData];
}

/** 完成/删除 */
- (void)done {
    for (MyMessageModel *model in self.dataArray) {
        model.editing = NO;
    }
    [self deleteSelectedCells];
    [self.tableView reloadData];
}

- (void)deleteSelectedCells {
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        MyMessageModel *model = self.dataArray[i];
        if (model.isCheck) {
            [set addIndex:i];
        }
    }
    [self.dataArray removeObjectsAtIndexes:set];
    [self.tableView reloadData];
}

@end
