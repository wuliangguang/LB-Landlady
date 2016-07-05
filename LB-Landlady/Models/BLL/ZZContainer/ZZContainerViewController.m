//
//  ContainerViewController.m
//  ContainerDemo
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 WeiZhenLiu. All rights reserved.
//

#import "ZZContainerViewController.h"
#import "UIViewController+ZZContainer.h"
#import <objc/runtime.h>

@interface ZZContainerViewController () <UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) ZZContainerTopbar *topbar;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic) ZZContainerConfiguration *configuration;
@end

@implementation ZZContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage            = currentPage;
    self.topbar.currentPage = currentPage;
    [self.scrollView setContentOffset:CGPointMake(_currentPage*_scrollView.frame.size.width, 0) animated:YES];
    UIViewController *controller = self.configuration.viewControllers[_currentPage];
    if (self.didChangeControllerHandler) {
        self.didChangeControllerHandler(controller);
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    self.currentPage = currentPage;
}

#pragma mark - config

- (void)makeConfiguration:(void (^)(ZZContainerConfiguration *configuration))configHandler {
    ZZContainerConfiguration *config = [[ZZContainerConfiguration alloc] init];
    configHandler(config);
    self.configuration = config;
}

- (void)setConfiguration:(ZZContainerConfiguration *)configuration {
    _configuration = configuration;
    [self setUp];
}

- (void)setUp {
    // top bar
    self.topbar = [[ZZContainerTopbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kTopbarHeight)];
    _topbar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    __weak __typeof(self) _self = self;
    _topbar.callbackHandler = ^(NSInteger currentPage) {
        [_self setCurrentPage:currentPage];
    };
    [self.view addSubview:_topbar];
    
    // scroll view
    CGFloat contentHeight = self.configuration.contentHeight == 0 ? CGRectGetHeight(self.view.frame)-kTopbarHeight : self.configuration.contentHeight;
    CGRect frame = CGRectMake(0, CGRectGetMaxY(self.topbar.frame), CGRectGetWidth(self.view.frame), contentHeight);
    if (self.configuration.contentHeight) {
        frame.size.height = self.configuration.contentHeight;
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.delegate                       = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.bounces                        = NO;
    _scrollView.pagingEnabled                  = YES;
    [self.view addSubview:_scrollView];
    
    // view controllers
    CGFloat x = 0.0;
    for (UIViewController *viewController in self.configuration.viewControllers) {
        [viewController willMoveToParentViewController:self];
        viewController.view.frame = CGRectMake(x, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
        
        viewController.containerViewController = self;
        
        x += CGRectGetWidth(self.scrollView.frame);
        _scrollView.contentSize = CGSizeMake(x, _scrollView.frame.size.height);
    }
    
    // topbar titles
    self.topbar.titles = [self.configuration.viewControllers valueForKey:@"title"];
    
    // setCurrentPage 回调代理
    self.currentPage = _currentPage;
}

- (NSArray *)viewControllers {
    return self.configuration.viewControllers;
}

- (void (^)(UIViewController *controller))didChangeControllerHandler {
    return self.configuration.didChangeControllerHandler;
}

- (void)dealloc {
    NSLog(@"DEALLOC");
}

@end
