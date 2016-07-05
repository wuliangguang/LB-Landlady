//
//  WaiterInfoTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "WaiterInfoTableVC.h"
#import <UIImageView+WebCache.h>

@interface WaiterInfoTableVC ()

@end

@implementation WaiterInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _num.text = [NSString stringWithFormat:@"%d",_model.salesclerk_id];
    _name.text = _model.salesclerk_name;
    _phone.text = _model.salesclerk_phone;
    _position.text = _model.salesclerk_job;
    _headerImageView.layer.cornerRadius = 20;
    _headerImageView.clipsToBounds = YES;
    if ([_model.salesclerk_image isEqualToString:@""]) {
        _headerImageView.image = [UIImage imageNamed:@"defultheadimage.png"];
    }else
    {
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.salesclerk_image] placeholderImage:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChangeInfoTableVC * changeVC = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"change"]) {
        changeVC.model = _model;
        [changeVC setCallbackHandler:^(WaiterListModel *model) {
            [self.tableView reloadData];
            if (self.callbackHandler) {
                self.callbackHandler(model);
                // [self.navigationController popViewControllerAnimated:NO];
            }
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 1) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:_model.salesclerk_phone, nil];
        sheet.actionSheetStyle =UIActionSheetStyleDefault;
        [sheet showInView:self.view];
    }
}


#pragma mark -------ActionSheetDelegate-----
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_model.salesclerk_phone]]];
    }
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
