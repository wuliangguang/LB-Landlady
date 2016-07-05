//
//  EditVIPMakeTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "EditVIPMakeTVC.h"

@interface EditVIPMakeTVC ()

@end

@implementation EditVIPMakeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑制定";
    [self initSureButton];
//    _switchOn.on = NO;
}
-(void)setIndex:(NSInteger)index
{
    _index = index;
    switch (index) {
        case 0:
            _vipRateTF.text = @"普通会员";
            _privilgeTF.text = @"10折";
            _needCostTf.text = @"0元";
            _switchOn.on = _model.status;
            if (!self.isChange) {
                _switchOn.enabled = NO;
            }else
            {
                _switchOn.enabled = YES;
            }
            _introduceTFView.text = _model.b_leve_detail;
            break;
            
        default:
            _vipRateTF.text = _model.b_level_name;
            _privilgeTF.text = [NSString stringWithFormat:@"%.1f折",_model.b_discount];
            _switchOn.on = _model.status;
            _needCostTf.text = [NSString stringWithFormat:@"%.1f元",_model.price];
            _introduceTFView.text = _model.b_leve_detail;
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)initSureButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 286, kScreenWidth-40, 40);
    [button setBackgroundColor:LD_COLOR_ONE];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确  认" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


#pragma mark ------ButtonClick------
- (IBAction)switchValueChange:(id)sender {
    UISwitch * switchs = (UISwitch *)sender;

//    BOOL defaultOn = _defaultModel.status;
//    BOOL otherOn = _model.status;
//    if (_model == _defaultModel) {
//        [self openVIPLevel:switchs.on];
//    }else
//    {
//        
//    }
    [self openVIPLevel:switchs.on];
}
-(void)sureBtnClick
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelFont = LK_FONT_SIZE_FOUR;
    NSLog(@"SureButtonClick");
    if ([_vipRateTF.text removeWhiteSpacesFromString].length ==0) {
        hud.labelText = @"请输入会员级别名称";
    }else if ([_introduceTFView.text removeWhiteSpacesFromString].length == 0) {
        hud.labelText = @"请输入会员权益及规则概述";
    }else
    {
        [self editVipRating];
    }
    [hud hide:YES afterDelay:ERROR_DELAY];
}
#pragma mark ------NetRequest-------
/**
 *  *@see 修改会员卡等级
	*		@param			levelId 	int	会员卡编号
 * 		@param			levelName	string		会员等级名称
 * 		@param			bDiscount	float		折扣
 * 		@param			price		float		最低消费
 * 		@param			levelDetail	string		描述
 */
-(void)editVipRating
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService changeVIPInfo];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:_vipRateTF.text  forKey:@"levelName"];
        [param setObject:[NSNumber numberWithFloat:[_privilgeTF.text floatValue]]   forKey:@"bDiscount"];
        [param setObject:[NSNumber numberWithFloat:[_needCostTf.text floatValue]]  forKey:@"price"];
        [param setObject:_introduceTFView.text  forKey:@"levelDetail"];
        [param setObject:[NSNumber numberWithInt:_model.b_level_id]  forKey:@"levelId"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {

            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                if (self.editSuccess) {
                    self.editSuccess();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}

/**
	*   开启关闭会员卡
	*	@param  	levelId		string			会员卡ID
	* 	@param  	status		string			状态
	* 	@return  data:{
 * 	code:  true:code=200,false:code!=200
 * 	dataCode: number	返回非错误逻辑性异常code
 * 	resultMsg: string 	返回信息
 * 	totalCount : int	返回总条数
 * 	data:{
 *
	* 	}
	*/
-(void)openVIPLevel:(BOOL)on
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getOpenOrCloseLevelUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        
        [param setObject:[NSNumber numberWithInt:_model.b_level_id]  forKey:@"levelId"];
        [param setObject:[NSNumber numberWithBool:on]  forKey:@"status"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
        
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
@end
