//
//  VIPAddTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "VIPAddTVC.h"
#import "AddVipCell.h"
#import "VipAddModel.h"

@interface VIPAddTVC ()
@property(nonatomic,strong)NSMutableArray * vipArr;
@end

@implementation VIPAddTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员新增";
    _vipArr = [[NSMutableArray alloc]init];
    
    [self getAllVips];
    
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
    return _vipArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddVipCell * cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"AddVipCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    VipAddModel * model = _vipArr[indexPath.row];
    cell.telNumLab.text = model.associator_phone;
    cell.associationId = model.associator_id;
    cell.cellBlock = ^(NSInteger status,NSInteger associationID){
        [self getUpdateApplyStatusUrl:status withAssociationID:associationID];
    };
    return cell;
}

#pragma mark ------NetRequest-------
/**
	* 查询门店下的所有会员
	* @param  	businessId		string		门店ID
	* @return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 * 		    associatorList[
 * 				{
 * 					id		int			会员卡编号
 * 					name 	int			姓名
 * 					sex		int			性别
 * 					phone	string		电话
 * 					address	float		地址
 * 					level	string		等级
 * 					detail	string		描述
 * 					isActive  int		是否活跃状态
 * 				},{...}
 * 			]
	* 	}
	*/
- (void)getAllVips
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getAssociatorUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:App_User_Info.myInfo.userModel.defaultBusiness  forKey:@"businessId"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            _vipArr = [VipAddModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"associatorList"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            NSLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
/**
	*    审核会员申请状态
	*	@param  	associatorId	string		会员卡ID
	*	@param  	status		string			状态  会员状态  1：通过 ，2：拒绝
	* 	@return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
-(void)getUpdateApplyStatusUrl:(NSInteger)status withAssociationID:(NSInteger)associationId
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getUpdateApplyStatusUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:[NSString stringWithFormat:@"%d",associationId]  forKey:@"associatorId"];
        [param setObject:[NSString stringWithFormat:@"%d",status]  forKey:@"status"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                [self getAllVips];
            }
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
@end
