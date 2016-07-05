//
//  ProductPoolCell.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/13.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    PRODUCTION_TYPE_ZHU  = 1,
    PRODUCTION_TYPE_HUO,
    PRODUCTION_TYPE_YOU,
    PRODUCTION_TYPE_TUAN,
    PRODUCTION_TYPE_SHANG,
    PRODUCTION_TYPE_NONE =100,
    
}PRODUCTION_TYPE;
@interface ProductPoolCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *PImageView;/**<产品图片*/
@property (strong, nonatomic) IBOutlet UILabel *PnameLab;/**<产品名称*/
@property (strong, nonatomic) IBOutlet UILabel *pCategroyLab;/**<产品类别*/
@property (strong, nonatomic) IBOutlet UILabel *pPriceLab;/**<产品价格*/

@property (strong, nonatomic) IBOutlet UIImageView *pStatusImageview;/**<产品状态，是团购还是优惠*/
@property (strong, nonatomic) IBOutlet UIButton *pstatusBtn;/**<产品是否已经下架*/
@property (strong, nonatomic) IBOutlet UILabel *pTimeLab;/**<产品时间*/
@property(nonatomic,assign)PRODUCTION_TYPE type;
@property(nonatomic,copy)void(^productionPoolBtnClickBlock)(int);
@end
