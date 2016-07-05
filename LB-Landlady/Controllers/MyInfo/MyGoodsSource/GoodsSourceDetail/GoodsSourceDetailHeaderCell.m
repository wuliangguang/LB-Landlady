//
//  GoodsSourceDetailHeaderCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "GoodsSourceDetailHeaderCell.h"
#import "UIImageView+WebCache.h"
#import "GLLabel.h"
#import "ZZCommonLimit.h"

@interface GoodsSourceDetailHeaderCell () <UITextFieldDelegate>

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  详情
 */
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/**
 *  输入数量
 */
@property (weak, nonatomic) IBOutlet UITextField *numTextField;

@end

@implementation GoodsSourceDetailHeaderCell

/**
 *  减，数量减1
 */
- (IBAction)subAction:(id)sender {
    NSInteger num = [self.numTextField.text integerValue];
    if (num <= 1) {
        return;
    }
    --num;
    self.numTextField.text = [NSString stringWithFormat:@"%ld", num];
    [self numDidChange:num];
}

/**
 *  加，数量加1
 */
- (IBAction)add:(id)sender {
    NSInteger num = [self.numTextField.text integerValue];
    self.numTextField.text = [NSString stringWithFormat:@"%ld", ++num];
    [self numDidChange:num];
}

- (void)numDidChange:(NSInteger)num {
    ProductPriceItem *priceItem = [self.dataModel priceItemForProductVolume:num];
    for (ProductPriceItem *item in self.dataModel.priceItemArray) {
        item.check = NO;
    }
    priceItem.check = YES;
    if (self.numDidChangeCallback) {
        self.numDidChangeCallback();
    }
}

- (NSInteger)inputNum {
    return [self.numTextField.text integerValue];
}

- (void)awakeFromNib {
    // Initialization code
    [ZZCommonLimit wordCountLimit:self.numTextField num:8];
    self.numTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setDataModel:(GoodSourceDetailDataModel *)dataModel {
    if (_dataModel != dataModel) {
        _dataModel                     = dataModel;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.productsrouce.image]];
        self.nameLabel.text            = dataModel.productsrouce.product_source_title;
        self.detailLabel.text          = dataModel.productsrouce.detail;
    }
    
    ProductPriceItem *priceItem = self.dataModel.checkedPriceItem;
    if (priceItem) {
        // self.priceLabel.text        = [priceItem priceStr];
        self.priceLabel.attributedText = [priceItem attributePriceStr];
        self.numTextField.text         = [NSString stringWithFormat:@"%ld", (NSInteger)priceItem.productVolume];
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 第一位禁止输入0
    if (textField.text.length <= 0 && [string integerValue] == 0) {
        return NO;
    }
    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self numDidChange:[aString integerValue]];
    return YES;
}

@end
