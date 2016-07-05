//
//  MyMessageCell.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/20/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageCell.h"

@interface MyMessageCell ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton; // 小圆点
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;  // 标题
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;   // 时间
@property (weak, nonatomic) IBOutlet UILabel *detailLabel; // 详情

@end

@implementation MyMessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)checkButtonClick:(id)sender {
    NSLog(@"ing");
    self.model.check = !self.model.isCheck;
    [self.iconButton setImage:[UIImage imageNamed:self.model.isCheck ? @"my_merchant_check" : @"my_merchant_not_check"]  forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(MyMessageModel *)model {
    if (_model != model) {
        _model = model;
        self.titleLabel.text  = model.message_title;
        self.timeLabel.text   = model.messageCreateTime;
        self.detailLabel.text = model.message_content;
    }
    
    if (model.isEditing) { // 处于编辑状态
        UIImage *image = [UIImage imageNamed:model.isCheck ? @"my_merchant_check" : @"my_merchant_not_check"];
        [self.iconButton setImage:image forState:UIControlStateNormal];
        self.iconButton.enabled = YES;
    } else {
        [self.iconButton setImage:model.is_read ? nil : [UIImage imageNamed:@"my_message_not_read"] forState:UIControlStateNormal];
        self.iconButton.enabled = NO;
    }
}

@end
