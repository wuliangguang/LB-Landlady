//
//  MySourcePublicTimeOptionView.m
//  LB-Landlady
//
//  Created by 刘威振 on 16/1/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "MySourcePublicTimeOptionView.h"

@interface MySourcePublicTimeOptionView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *dataArray;
@property (nonatomic, copy) void (^completionHandler)(MySourcePublicTimeOptionType type, NSString *str);
@end

@implementation MySourcePublicTimeOptionView

- (void)setUp {
    CGRect frame                  = [[UIScreen mainScreen] bounds];
    frame.origin.y                = CGRectGetHeight(frame);
    self.frame                    = frame;
    self.backgroundColor          = ColorA(.5, .5, .5, .5);
    self.dataArray                = @[@"7日内", @"1月内", @"1年内", @"长期有效", @"自定义时间"];
    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height-220, frame.size.width, 220)];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self addSubview:self.tableView];
    NSLog(@"%@", [[UIApplication sharedApplication] keyWindow]);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)showWithType:(MySourcePublicTimeOptionType)type completionHandler:(void (^)(MySourcePublicTimeOptionType type, NSString *typeInfo))completionHandler {
    [self setUp];
    self.type              = type;
    self.completionHandler = completionHandler;
    CGRect frame           = self.frame;
    frame.origin.y         = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.frame = frame;
    } completion:nil];
}

- (void)setType:(MySourcePublicTimeOptionType)type {
    _type = type;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell        = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row == self.type) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text          = self.dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
    
    return cell;
}

// 分割线左对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.type = indexPath.row;
    [tableView reloadData];
    if (self.completionHandler) {
        self.completionHandler(self.type, self.dataArray[indexPath.row]);
    }
    [self dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)dismiss {
    CGRect frame = self.frame;
    frame.origin.y += frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end



