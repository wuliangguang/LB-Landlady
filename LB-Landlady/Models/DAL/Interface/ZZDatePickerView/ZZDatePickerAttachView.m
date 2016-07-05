//
//  ZZDatePickerAttachView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/19/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZDatePickerAttachView.h"

@interface ZZDatePickerAttachView ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ZZDatePickerAttachView

- (void)awakeFromNib {
    [self initUI];
}

- (void)initUI {
    if (self.currentDate) {
        self.datePicker.date = self.currentDate;
    }
}

/* 取消 */
- (IBAction)cancel:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler(nil);
    }
}

/* 确定 */
- (IBAction)done:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler(self.datePicker.date);
    }
}

@end
