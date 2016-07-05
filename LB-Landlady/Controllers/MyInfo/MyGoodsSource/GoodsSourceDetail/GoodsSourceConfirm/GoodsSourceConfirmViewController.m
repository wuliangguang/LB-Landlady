//
//  GoodsSourceConfirmViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/24/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "GoodsSourceConfirmViewController.h"
#import "UIImageView+WebCache.h"
#import "CommonModel.h"
#import "MBProgressHUD+ZZConvenience.h"

@interface GoodsSourceConfirmViewController ()

// cell 1
@property (weak, nonatomic) IBOutlet UIImageView *merchantImageView;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;

// cell 2
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

// cell 3
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

// cell 4
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

@implementation GoodsSourceConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认下单";
    [self initUI];
}

- (void)initUI {
    // cell 1
    self.merchantNameLabel.text = self.dataModel.businessinfo.data.businessName;
    
    // cell 2
    self.nameLabel.text = App_User_Info.myInfo.businessModel.contactName;
    self.phoneLabel.text = App_User_Info.myInfo.businessModel.mobile;
    self.locationLabel.text = App_User_Info.myInfo.businessModel.address; // self.dataModel.businessinfo.data.address;
    
    // cell 3
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.productsrouce.image] placeholderImage:[UIImage imageNamed:@"default_1_1"]];
    self.goodsNameLabel.text       = self.dataModel.productsrouce.product_source_title;
    self.priceLabel.attributedText = [self.choosedPriceItem attributePriceStr];
    self.numLabel.text             = [NSString stringWithFormat:@"%ld", (NSInteger)self.choosedPriceItem.productVolume];

    // cell 4
    self.totalPriceLabel.text = [self.choosedPriceItem totalPriceStr];
}

/** 确认订单 */
- (IBAction)confirm:(id)sender {
    /**
     * @see 添加货源线下订单
     * @author kai.li
     * @param  productSrouceId	string 货源ID
     *	@param  businessId	string     店铺Id
     *	@param  buyBusinessId string 购买店铺ID
     *	@param	orderPrice	string	订单总价
     *	@param	plantformId	string	终端类型
     *	@param	userName	string	收货人姓名
     *	@param	phone		string	收货人电话
     *	@param	address	string		地址
     *	@param	amount	string		货源总价
     *	@param	price	string		货源价格
     *	@param	num	string		货源数量
     * @return  data:{
     * 	code:  true:code=200,false:code!=200
     dataCode: number	返回非错误逻辑性异常code
     resultMsg: string 	返回信息
     totalCount : int	返回总条数
     data:{
     orderId	string  订单号
     }
     }
     */

    
    
    FMLog(@"%@" ,self.dataModel.productsrouce.product_source_id);
    
    FMLog(@"%@" ,App_User_Info.myInfo.userModel.defaultBusiness);
    
    FMLog(@"%@" ,self.dataModel.productsrouce.business_id);
    
    FMLog(@"%@" ,[NSString stringWithFormat:@"%lf", [self.choosedPriceItem totalPrice]]);
    
    FMLog(@"%@" ,App_User_Info.myInfo.userModel.username);
    
    FMLog(@"%@" ,App_User_Info.myInfo.userModel.mobile);
    
    FMLog(@"%@" ,[NSString stringWithFormat:@"%lf", [self.choosedPriceItem totalPrice]]);
    
    
    FMLog(@"%@" ,[NSString stringWithFormat:@"%lf", self.choosedPriceItem.priceVolume]);
    
     FMLog(@"%@" ,[NSString stringWithFormat:@"%lf", self.choosedPriceItem.productVolume]);
    NSDictionary *param = @{
                            @"productSrouceId" : self.dataModel.productsrouce.product_source_id, // 货源ID
                            @"businessId" : App_User_Info.myInfo.userModel.defaultBusiness, // 店铺Id
                            @"buyBusinessId" : self.dataModel.productsrouce.business_id, // 购买店铺ID
                            @"orderPrice" : [NSString stringWithFormat:@"%lf", [self.choosedPriceItem totalPrice]], // 订单总价 == 货源总价
                            @"plantForm" : @"1", // 终端类型
                            @"userName" : [NSString stringWithFormat:@"%@",App_User_Info.myInfo.userModel.username], // 收货人姓名,使用stringWithFormat原因是没填写个人信息直接绑定店铺，则username为null此时dict保存空值会crash
                            @"phone" : App_User_Info.myInfo.userModel.mobile, // 收货人电话
                            @"address" : @"测试地址，未定", // 地址
                            @"amount" : [NSString stringWithFormat:@"%lf", [self.choosedPriceItem totalPrice]], // 货源总价
                            @"price" : [NSString stringWithFormat:@"%lf", self.choosedPriceItem.priceVolume], // 货源价格 单价
                            @"num" : [NSString stringWithFormat:@"%lf", self.choosedPriceItem.productVolume] // 货源数量
                            };

    
    [S_R LB_GetWithURLString:[URLService addProductSourceOrderUrl] WithParams:param WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            [MBProgressHUD showSuccessToast:@"下单成功" inView:self.view completionHandler:nil];
            UIViewController *controller = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
            [self.navigationController popToViewController:controller animated:YES];
        } else {
            [MBProgressHUD showFailToast:@"下单失败" inView:self.view completionHandler:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    } WithController:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

@end
