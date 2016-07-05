//
//  MyMessageAllViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/20/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageAllViewController.h"
#import "ZZContainerViewController.h"
#import "CommonModel.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface MyMessageAllViewController ()

@end

@implementation MyMessageAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataArray = [[NSMutableArray alloc]init];
    [self fetchWebData];
}

- (void)fetchWebData {
    /**
     * 显示门店信息
     * @param	businessId		string  门店Id
     * @param    currentPageNum	int			当前页面数
     * @param	pageSize		int			获取数据数
     * @return  data:{
     * 	code:  true:code=200,false:code!=200
     * 	dataCode: number	返回非错误逻辑性异常code
     * 	resultMsg: string 	返回信息
     * 	totalCount : int	返回总条数
     * 	data:{
     * 		messageList[
     * 		{
     * 			messageId	int
     * 			messageType	int
     * 			messageTitle	string
     * 			messageContent	string
     * 			createTime		string
     * 			businessId		string
     * 			isRead			int
     * 		},{...}
     * 	]
     * }
     *	}
     */
    NSDictionary *dict = @{
                           @"businessId" : App_User_Info.myInfo.userModel.defaultBusiness,
                           @"currentPageNum" : @"0",
                           @"pageSize" : @"30"
                           };
    [S_R LB_GetWithURLString:[URLService getMessageListUrl] WithParams:dict WithSuccess:^(id responseObject, id responseString) {
        // NSLog(@"%@", responseString);
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject dataClass:[MyMessageDataModel class]];
        if (commonModel.code == SUCCESS_CODE) {
            MyMessageDataModel *dataModel = commonModel.data;
            self.dataArray = [[NSMutableArray alloc]initWithArray:dataModel.message];
            [self dispatchModels];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showFailToast:@"数据请求失败" inView:self.view completionHandler:nil];
    } WithController:self];
}

- (void)refreshTableView {
    for (MyMessageBaseViewController *controller in self.containerViewController.viewControllers) {
        [controller.tableView reloadData];
    }
}

// 分发model对象
- (void)dispatchModels {
    // TODO:// 分发Model对象
    // 系统消息 | 订单消息 | 订制消息
    NSMutableArray *systemArray = [NSMutableArray array];
    NSMutableArray *orderArray  = [NSMutableArray array];
    NSMutableArray *customArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        MyMessageModel *model = self.dataArray[i];
        switch (model.message_type) {
            case MyMessageTypeSystem: {
                [systemArray addObject:model];
                break;
            }
            case MyMessageTypeOrder: {
                [orderArray addObject:model];
                break;
            }
            case MyMessageTypeCustom: {
                [customArray addObject:model];
                break;
            }
            default:
                break;
        }
        
        // 相当于
        // model.message_type == MyMessageTypeSystem ? [systemArray addObject:model] : (model.message_type == MyMessageTypeOrder ? [orderArray addObject:model] : [customArray addObject:model]);
    }
    
    NSArray *subArray = @[systemArray, orderArray, customArray];
    NSArray *viewControllers = self.containerViewController.viewControllers;
    if (viewControllers.count <= 0) {
        return;
    }
    for (NSInteger i = 0; i < 3; i++) {
        MyMessageBaseViewController *controller = viewControllers[i+1];
        controller.dataArray = subArray[i];
    }
    
    [self refreshTableView];
}

// 四个模块全进入编辑状态
- (void)edit {
    [super edit];
    for (NSInteger i = 1; i < self.containerViewController.viewControllers.count; i++) {
        MyMessageBaseViewController *controller = [self.containerViewController.viewControllers objectAtIndex:i];
        [controller edit];
    }
}

// 四个模块全进入编辑完成状态（重新刷新）
- (void)done {
    if (self.dataArray.count <=0) {
        return;
    }
    NSString *str = [self checkedMessageIds];
    if (str.length <= 0) {
        return;
    }
    [S_R LB_GetWithURLString:[URLService getDelMessageUrl] WithParams:@{@"messageId" : str} WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            [super done]; // 删除数据源
            for (NSInteger i = 1; i < self.containerViewController.viewControllers.count; i++) {
                MyMessageBaseViewController *controller = [self.containerViewController.viewControllers objectAtIndex:i];
                [controller done];
            }
        }
    } failure:^(NSError *error) {
        
    } WithController:self];
}

- (NSString *)checkedMessageIds {
    NSMutableString *messageIds = [NSMutableString string];

    for (NSInteger i = 0; i < self.dataArray.count - 1; i++) {
        MyMessageModel *message = [self.dataArray objectAtIndex:i];
        if (message.check) {
            [messageIds appendFormat:@"%@,", message.message_id];
        }
    }

//    MyMessageModel *message = [self.dataArray lastObject];
//    [messageIds appendString:message.message_id];
    return messageIds;
}

@end



