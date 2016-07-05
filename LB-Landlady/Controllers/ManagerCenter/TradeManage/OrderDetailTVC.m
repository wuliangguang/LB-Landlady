//
//  OrderDetailTVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OrderDetailTVC.h"
#import "OrderListDetailModel.h"
#import <UIImageView+WebCache.h>


@interface OrderDetailTVC ()
{
    UIButton * rejectButton;
    UIButton * OKButton;
}
@property(nonatomic,strong)NSArray * detailModelArr;
@end

@implementation OrderDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self getOrderDetail];
#warning type == 待处理
    if (_type == 1) {
        [self creatButton];
    }
    
}
-(void)getOrderDetail
{
    NSString * pathStr = [URLService getOrder];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:self.orderId forKey:@"orderId"];
    [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
        FMLog(@"%@",responseString);
        _detailModelArr  =[OrderListDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        OrderListDetailModel * model = _detailModelArr[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.orderNumLab.text =model.order_id;
            switch (model.status) {
                case 1:
                    self.orderStatusLab.text = @"待处理";
                    self.orderStatusLab.backgroundColor = LD_COLOR_FOUR;
                    break;
                case 2:
                    self.orderStatusLab.text= @"已接受";
                    self.orderStatusLab.backgroundColor = LD_COLOR_SIX;
                    break;
                case 3:
                    self.orderStatusLab.text = @"已完成";
                    self.orderStatusLab.backgroundColor = LD_COLOR_SIX;
                    break;
                case 4:
                    self.orderStatusLab.text = @"已拒绝";
                    self.orderStatusLab.backgroundColor = LD_COLOR_TWELVE;
                    break;
                case 5:
                    self.orderStatusLab.text = @"客户拒绝";
                    self.orderStatusLab.backgroundColor = LD_COLOR_TWELVE;
                    break;
                default:
                    break;
            }
            self.linkerNameLab.text = model.user_name;
            self.linkerTelLab.text = model.phone;
            self.linkerAddressLab.text = model.address;
            self.timeLab.text = model.createTime;
            [self.orderImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed: @"default_1_1"]];
            self.orderNameLab.text = model.productName;
            self.orderPerPriceLab.text = [NSString stringWithFormat:@"x%d",model.num];
            if (model.price == NULL) {
                self.totalPriceLab.text = [NSString stringWithFormat:@"￥%.2f",model.amount* model.num];
            }else
            {
                self.totalPriceLab.text =[NSString stringWithFormat:@"￥%.2f",[[[model.price componentsSeparatedByString:@"-"] firstObject] floatValue]*model.num];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    } failure:^(NSError *error) {
        
    } WithController:self];
}
-(void)creatButton
{
    rejectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rejectButton.frame = CGRectMake(20, CGRectGetMaxY(_lastCell.frame), (kScreenWidth-60)/2.0, 45);
    rejectButton.backgroundColor = [UIColor lightGrayColor];
    [rejectButton addTarget:self action:@selector(reject) forControlEvents:UIControlEventTouchUpInside];
    [rejectButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [self.view addSubview:rejectButton];
    
    
    OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    OKButton.frame = CGRectMake(40 + (kScreenWidth-60)/2.0, CGRectGetMaxY(_lastCell.frame), (kScreenWidth-60)/2.0, 45);
    OKButton.backgroundColor = [UIColor redColor];
    [OKButton setTitle:@"接受" forState:UIControlStateNormal];
    [OKButton addTarget:self action:@selector(OKClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OKButton];
    
}


-(void)OKClick
{
    [self rejectOrReceiveOrderWithStatus:@"2"];
}
-(void)reject
{
    [self rejectOrReceiveOrderWithStatus:@"4"];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------NetRequest-------
-(void)rejectOrReceiveOrderWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService updateOrderStatuUrl];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:self.orderId forKey:@"orderId"];
        [param setObject:status forKey:@"status"];
        [S_R LB_GetWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                rejectButton.hidden = YES;
                OKButton.hidden = YES;
                [self getOrderDetail];
            }
        } failure:^(NSError *error) {
            FMLog(@"error = %@",error.userInfo);
        } WithController:self];
    });
}
@end
