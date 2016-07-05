//
//  MySourcePublicTimeView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublicTimeView.h"

@implementation MySourcePublicTimeModel

- (instancetype)initWithType:(NSInteger)type info:(NSString *)info {
    if (self = [super init]) {
        self.type     = type;
        self.typeInfo = info;
    }
    return self;
}
@end

@implementation MySourcePublicTimeView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

- (void)setModel:(MySourcePublicTimeModel *)model {
    _model = model;
    self.infoLabel.text = model.typeInfo;
}

@end
