//
//  DateCollectionCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/14.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "DateCollectionCell.h"
#import "HEXColor.h"

@implementation DateCollectionCell

- (void)awakeFromNib {
    self.button.layer.borderWidth = 2;
    _button.layer.cornerRadius = 15;
    _button.clipsToBounds = YES;
    _button.textAlignment = NSTextAlignmentCenter;
//    [_button setTitleColor:[HEXColor getColor:@"#ededed"] forState:UIControlStateNormal];
}

- (void)setType:(DateCollectionCellType)type {
    _type = type;
    switch (_type) {
        case DateCollectionCellTypeDisable: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.button.textColor = [HEXColor getColor:@"#ededed"];
                self.button.layer.borderColor = [HEXColor getColor:@"#efefef"].CGColor;
                self.button.backgroundColor   = [UIColor clearColor];
            });
            
        }
            break;
        case DateCollectionCellTypeEnableNotChoose: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.button.textColor = [HEXColor getColor:@"ff3c25"];
                self.button.layer.borderColor = [HEXColor getColor:@"#efefef"].CGColor;
                self.button.backgroundColor = [HEXColor getColor:@"#fbfbfb"];
            });
        }
            break;
        case DateCollectionCellTypeEnableDidChoose: {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.button.backgroundColor = [UIColor redColor];
                self.button.textColor = [UIColor whiteColor];
                self.button.layer.borderColor = [UIColor redColor].CGColor;
            });
        }
            break;
        default:
            break;
    }
}

@end
