//
//  MySourcePublicInputView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublicInputView.h"
#import "NSString+Helper.h"

@interface MySourcePublicInputView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *manageButton;

/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UITextField *numField;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UITextField *priceField;

@end

@implementation MySourcePublicInputView

- (IBAction)add:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler(self);
    }
}

- (void)awakeFromNib {
    self.leftView.layer.cornerRadius  = 8.0f;
    self.rightView.layer.cornerRadius = 8.0f;
    self.unitField.delegate = self;
}

- (void)setMode:(MySourcePublicInputViewMode)mode {
    _mode = mode;
    UIImage *image = mode ==  MySourcePublicInputViewModeAdd ? [UIImage imageNamed:@"my_source_add"] : [UIImage imageNamed:@"my_source_subtract"];
    [self.manageButton setImage:image forState:UIControlStateNormal];
}

- (MySourcePublicInputInfoModel *)info {
    // view.inputModel.toString
    NSString *num   = self.numField.text;   // 数量
    NSString *unit  = self.unitField.text;  // 单位
    NSString *price = self.priceField.text; // 价格
    MySourcePublicInputInfoModel *inputModel = [[MySourcePublicInputInfoModel alloc] init];
    inputModel.num   = [num removeWhiteSpacesFromString];
    inputModel.unit  = [unit removeWhiteSpacesFromString];
    inputModel.price = [price removeWhiteSpacesFromString];
    return inputModel;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.textDidChangeCallback) {
        self.textDidChangeCallback(aString);
    }
    return YES;
}

@end
