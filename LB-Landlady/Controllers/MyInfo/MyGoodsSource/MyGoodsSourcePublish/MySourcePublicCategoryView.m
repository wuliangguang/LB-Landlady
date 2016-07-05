//
//  MySourcePublicCategoryView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublicCategoryView.h"

@interface MySourcePublicCategoryView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation MySourcePublicCategoryView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

- (void)setModel:(IndustryModel *)model {
    _model = model;
    self.nameLabel.text = model.industryName;
}

@end
