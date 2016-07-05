//
//  MySourcePublicInputView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySourcePublicInputInfoModel.h"

typedef NS_ENUM(NSInteger, MySourcePublicInputViewMode) {
    MySourcePublicInputViewModeAdd,
    MySourcePublicInputViewModeSubtract
};

@interface MySourcePublicInputView : UIView
/**
 *  数量单位
 */
@property (weak, nonatomic) IBOutlet UITextField *unitField;

@property (nonatomic, copy) void (^callbackHandler)(MySourcePublicInputView *inputView);
@property (nonatomic, copy) block_id_t textDidChangeCallback;
@property (nonatomic) MySourcePublicInputViewMode mode;

- (MySourcePublicInputInfoModel *)info;

@end
