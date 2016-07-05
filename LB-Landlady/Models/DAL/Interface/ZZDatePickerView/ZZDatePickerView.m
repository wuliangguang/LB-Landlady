//
//  ZZDatePickerView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/19/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZDatePickerView.h"
#import "ZZDatePickerAttachView.h"

static ZZDatePickerView *_pickerView;

@interface ZZDatePickerView ()

@property (nonatomic) ZZDatePickerAttachView *attachView;
@property (nonatomic, copy) void (^callbackHandler)(NSDate *date);
@end

@implementation ZZDatePickerView

+ (ZZDatePickerView *)sharedPickerView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _pickerView = [[ZZDatePickerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _pickerView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    });
    return _pickerView;
}

+ (void)showWithTitle:(NSString *)title date:(NSDate *)date completionHandler:(void (^)(NSDate *date))callbackHandler {
    ZZDatePickerView *pickerView = [self sharedPickerView];
    pickerView.callbackHandler = callbackHandler;
    [pickerView manageCallback:callbackHandler];
    pickerView.attachView.titleLabel.text = title;
    [pickerView show:date];
}

- (void)manageCallback:(void (^)(NSDate *date))callbackHandler {
    self.callbackHandler = callbackHandler;
    __weak __typeof(self) weakself = self;
    self.attachView.callbackHandler = ^(NSDate *date) {
        if (date && weakself.callbackHandler) {
            weakself.callbackHandler(date);
        }
        [[weakself class] dismiss];
    };
}

- (ZZDatePickerAttachView *)attachView {
    if (_attachView == nil) {
        _attachView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZZDatePickerAttachView class]) owner:nil options:nil] firstObject];
    }
    return _attachView;
}

- (void)show:(NSDate *)date {
    ZZDatePickerView *pickerView = [ZZDatePickerView sharedPickerView];
    pickerView.backgroundColor   = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [pickerView makeKeyWindow];
    [pickerView setHidden:NO];
    
    CGRect screen               = [[UIScreen mainScreen] bounds];
    CGFloat height              = 236.0;
    CGRect frame                = CGRectMake(0, screen.size.height, screen.size.width, height);
    self.attachView.frame       = frame;
    self.attachView.currentDate = date;
    [self addSubview:self.attachView];
    frame.origin.y -= height;
    [UIView animateWithDuration:0.25 animations:^{
        self.attachView.frame = frame;
    } completion:^(BOOL finished) {
        NSLog(@"ZZDatePickerView 动画结束");
    }];
}

+ (void)dismiss {
    ZZDatePickerView *pickerView = [self sharedPickerView];
    CGRect frame = pickerView.attachView.frame;
    frame.origin.y += frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        pickerView.attachView.frame = frame;
    } completion:^(BOOL finished) {
        [pickerView setHidden:YES];
        [pickerView.attachView removeFromSuperview], pickerView.attachView = nil;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self class] dismiss];
}

@end
