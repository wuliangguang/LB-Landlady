//
//  HomeGoodsSupplyCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "HomeGoodsSupplyCell.h"
#import "ItemTitleButton.h"
#import "NSObject+Helper.h"
#import "UIImageView+WebCache.h"

@interface HomeGoodsSupplyCell ()

@property (nonatomic) ItemTitleButtonListView *titleButtonListView;
@end

@implementation HomeGoodsSupplyCell

- (void)awakeFromNib {
    CGFloat width            = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height           = width/4.0 + 20;
    self.titleButtonListView = [[ItemTitleButtonListView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    __weak __typeof(self)weakself = self;
    self.titleButtonListView.callbackHandler = ^(id obj) {
        if (weakself.callbackHandler && obj) {
            weakself.callbackHandler(obj);
        }
    };
    [self.contentView addSubview:self.titleButtonListView];
}

- (void)setProductDataModel:(GoodSourceProductDataModel *)productDataModel {
    if (_productDataModel != productDataModel) {
        _productDataModel = productDataModel;
        NSUInteger count  = MIN(productDataModel.productSourceList.count, 4);
        for (NSUInteger i = 0; i < count; i++) {
            GoodSourceProductModel *productModel = productDataModel.productSourceList[i];
            ItemTitleButton *titleButton = [self.titleButtonListView.items objectAtIndex:i];
            titleButton.textLabel.numberOfLines = 2;
            [titleButton.imageView sd_setImageWithURL:[NSURL URLWithString:productModel.image] placeholderImage:[UIImage imageNamed:@"default_main_1_1"]];
            titleButton.textLabel.numberOfLines = 2;
            titleButton.textLabel.text          = productModel.product_source_title;
            titleButton.attachObject            = productModel;
        }
    }
}

@end
