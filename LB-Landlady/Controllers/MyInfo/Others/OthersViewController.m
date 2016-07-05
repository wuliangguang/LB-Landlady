//
//  OthersViewController.m
//  LB-Landlady
//
//  Created by d2space on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "OthersViewController.h"
#import "LoginManager.h"

@interface OthersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OthersViewController

#pragma mark ************************** Btn Method

- (IBAction)logoutWithBtn:(UIButton *)sender {
    [LoginManager logoutWithCompletionHandler:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ************************** TableView Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"feedBackCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.textLabel.text = @"意见反馈";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"ToGoFeedBack" sender:nil];
}
#pragma mark ************************** VC LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"其他";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
