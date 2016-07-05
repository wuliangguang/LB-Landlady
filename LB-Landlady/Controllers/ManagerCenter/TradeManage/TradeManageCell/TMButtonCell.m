    //
//  TMButtonCell.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/14.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "TMButtonCell.h"



@interface TMButtonCell ()

@property (strong, nonatomic) IBOutlet UIButton *button;

@end

IB_DESIGNABLE
@implementation TMButtonCell

- (void)awakeFromNib {
    _button.backgroundColor = LD_COLOR_ONE;
    // Initialization code
//    _button.layer.cornerRadius
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_button != sender) {
        _button.selected = NO;
        _button.backgroundColor = LD_COLOR_THIRTEEN;
        sender.selected = YES;
        sender.backgroundColor = LD_COLOR_ONE;
        _button = sender;
    }
    self.buttonClickBlock(_button.tag-1);
    
}

@end
