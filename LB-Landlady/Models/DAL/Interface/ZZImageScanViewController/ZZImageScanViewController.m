//
//  ZZImageScanViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/15/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ZZImageScanViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "ZZActionButton.h"

@interface ZZImageScanViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic      ) UIImageView  *imageView;
@property (nonatomic      ) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView       *bottomView;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *singleTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTapGesture;

@end

@implementation ZZImageScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initUI {
    if (self.image == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    /* imageView on scrollView */
    CGRect rect                     = self.view.bounds;
    UIScrollView *scrollView        = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.backgroundColor      = [UIColor blackColor];
    scrollView.minimumZoomScale     = 0.5;
    scrollView.maximumZoomScale     = 3.0;
    scrollView.delegate             = self;
    self.scrollView                 = scrollView;
    self.imageView                  = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.contentMode      = UIViewContentModeScaleAspectFit;
    self.imageView.frame            = rect;
    [self.view addSubview:self.scrollView];
    [scrollView addSubview:self.imageView];
    [self.view sendSubviewToBack:scrollView];
    
    self.bottomView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7];
    
    // create a relationship with another gesture recognizer that will prevent this gesture's actions from being called until otherGestureRecognizer transitions to UIGestureRecognizerStateFailed
    // if otherGestureRecognizer transitions to UIGestureRecognizerStateRecognized or UIGestureRecognizerStateBegan then this recognizer will instead transition to UIGestureRecognizerStateFailed
    // example usage: a single tap may require a double tap to fail
    // - (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)otherGestureRecognizer;
    [self.singleTapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)delete:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.callbackHandler) {
            self.callbackHandler();
        }
    }];
}

- (IBAction)tap:(id)sender {
    static BOOL isShow = YES;
    isShow = !isShow;
    if (isShow) {
        self.bottomView.hidden = NO;
        [UIView animateWithDuration:.25 animations:^{
            self.bottomView.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:.25 animations:^{
            self.bottomView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.bottomView.hidden = YES;
        }];
    }
}

- (IBAction)doubleTap:(id)sender {
    CGFloat scaleValue = self.scrollView.zoomScale;
    [self.scrollView setZoomScale:scaleValue == 1.0 ? 2.0 : 1.0 animated:YES];
}

- (void)hiddenBottomView {
    [UIView animateWithDuration:.25 animations:^{
        self.bottomView.alpha = 0.7f;
    }];
}

- (void)showBottomView {
    CGRect frame = self.bottomView.frame;
    frame.origin.y = kScreenHeight - frame.size.height;
    [UIView animateWithDuration:.25 animations:^{
        self.bottomView.frame = frame;
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // 返回要缩放的视图，一般返回的是在scrollView上的东西，而不要scrollView本身
    return scrollView.subviews[0];
}

#pragma mark - <UIGestureRecognizerDelegate>
// 是否允许识别多个手势
// 一个手势检测到了，并不影响另一个手势的检测
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/**
- (void)dealloc {
    NSLog(@"%s", __func__);
}*/

@end
