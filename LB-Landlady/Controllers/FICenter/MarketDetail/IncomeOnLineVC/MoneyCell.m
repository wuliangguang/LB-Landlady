//
//  MoneyCell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/10/28.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "MoneyCell.h"

@interface MoneyCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MoneyCell

- (void)awakeFromNib {
    // Initialization code
    self.textField.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *str = [textField.text stringByAppendingString:string];
    if ([str isEqualToString:@"."]) {
        textField.text = @"0.";
        return NO;
    }
    return [str validateWithRegex:@"^[1-9]{0,}0?\\.?([0-9]{1,2})?$"];
}

@end
