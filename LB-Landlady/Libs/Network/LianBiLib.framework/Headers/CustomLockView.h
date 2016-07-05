//
//  CustomLockView.h
//  MeZoneB
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomLockView;
@protocol CustomLockViewDelegate <NSObject>
@optional
- (void)gestureLockView:(CustomLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(CustomLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(CustomLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode;

@end

@interface CustomLockView : UIView
@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;
@property (nonatomic, strong) UIImage *normalGestureNodeImage;
@property (nonatomic, strong) UIImage *selectedGestureNodeImage;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong, readonly) UIView *contentView;//the container of the gesture notes
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, weak) id <CustomLockViewDelegate> delegate;
@end
