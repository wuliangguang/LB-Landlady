//
//  CollectionViewCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setServerModel:(ServermalllistModel *)serverModel {
    if (_serverModel != serverModel) {
        _serverModel = serverModel;
        // [self.iconImageView sd_setImage...] // 服务器还没有给图片链接
        self.iconImageView.image = [UIImage imageNamed:@"default_1_1"];
        self.textLabel.text = serverModel.mall_name;
    }
}

@end
