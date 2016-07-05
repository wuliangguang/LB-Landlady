//
//  DirectivePageViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/12/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "DirectivePageViewController.h"
#import "PowerfulBannerView.h"

@interface DirectivePageViewController ()

@property (nonatomic) PowerfulBannerView *bannerView;
@end

@implementation DirectivePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.bannerView = [[PowerfulBannerView alloc] initWithFrame:self.view.bounds];
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"direct_image_%d", i]];
        [items addObject:image];
    }
    self.bannerView.items = items;
    self.bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        // 尽可能重用视图
        UIImageView *imageView = (UIImageView *)reusableView;
        if (!imageView) {
            imageView = [[UIImageView alloc] initWithImage:item];
        }
        return imageView;
    };
    __weak __typeof(self) weakself = self;
    
    /**
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bannerView.frame)-20, self.bannerView.frame.size.width, 20)];
    pageControl.backgroundColor = [UIColor clearColor];
    self.bannerView.pageControl = pageControl;
    [self.bannerView addSubview:pageControl];
     */
    
    self.bannerView.bannerDidSelectBlock = ^(PowerfulBannerView *banner, NSInteger index) {
        if (index == banner.items.count - 1) { // 最后一张
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didAccess"];
            if (weakself.endCallback) {
                weakself.endCallback();
            }
        }
    };
    
    [self.view addSubview:self.bannerView];
}

@end
