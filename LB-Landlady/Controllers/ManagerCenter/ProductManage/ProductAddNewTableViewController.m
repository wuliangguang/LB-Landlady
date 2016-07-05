//
//  ProductAddNewTableViewController.m
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/19.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "ProductAddNewTableViewController.h"
#import "ProductAddNewNameCell.h"
#import "ProductAddNewIntroductionCell.h"
#import "ProductAddNewPriceCell.h"
#import "UITableViewCell+ZZAddLine.h"
#import "ProductImageCell.h"
#import "ProductInventoryCell.h"
#import "ZZImagePickerManager.h"
#import "ProductAddNewModel.h"
#import "MBProgressHUD+ZZConvenience.h"
@interface ProductAddNewTableViewController ()
@property (nonatomic,strong)ProductAddNewModel *model;
@end

@implementation ProductAddNewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[ProductAddNewModel alloc]init];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self registerNib:[ProductAddNewNameCell class]];
    [self registerNib:[ProductAddNewIntroductionCell class]];
    [self registerNib:[ProductAddNewPriceCell class]];
    [self registerNib:[ProductImageCell class]];
    [self registClass:[UITableViewCell class]];
    [self registerNib:[ProductInventoryCell class]];
    self.tableView.separatorStyle = NO;
    [self creatSaveButton];
}
- (void)creatSaveButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.tableView.bounds.size.width/2-self.tableView.bounds.size.width/4, 50+80+5+50+10+40+150+50+5+20, self.tableView.bounds.size.width/2, 50);
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:button];
}
- (void)saveUp:(UIButton *)button{
    [self.view endEditing:YES];
    if ([self isAgreeDown] == NO) {
        return;
    }
}
- (BOOL)isAgreeDown{
    if ([self.model.nameString isEqualToString:@""] || self.model.nameString == nil) {
        [MBProgressHUD showFailToast:@"商品名称不能为空" inView:self.view completionHandler:nil];
        return NO;
    }
    if([self.model.inString isEqualToString:@""] || self.model.inString == nil){
        [MBProgressHUD showFailToast:@"商品简介不能为空" inView:self.view completionHandler:nil];
        return NO;
    }
    if([self.model.priceString isEqualToString:@""] || self.model.priceString == nil){
        [MBProgressHUD showFailToast:@"商品价格不能为空" inView:self.view completionHandler:nil];
        return NO;
    }
    char c = [self.model.priceString characterAtIndex:0];
    if (c <= '9' && c>='0') {
        
    }else{
        [MBProgressHUD showFailToast:@"价格输入错误" inView:self.view completionHandler:nil];
        return NO;
    }
    if (self.model.productImage == nil ) {
        [MBProgressHUD showFailToast:@"商品主图片不能为空" inView:self.view completionHandler:nil];
    }
    return YES;
}
- (void)registClass:(Class)cls{
    [self.tableView registerClass:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)registerNib:(Class)cls{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 40;
            break;
        case 4:
            return 150;
            break;
        case 5:
            return 50;
            break;
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 0;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 10;
            break;
        case 4:
            return 0;
            break;
        case 5:
            return 5;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            ProductAddNewNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductAddNewNameCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.blcok = ^(NSString *str){
                NSLog(@"--------------------%@",str);
                self.model.nameString = str;
            };
            return cell;
        }
            break;
        case 1:
        {
            ProductAddNewIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductAddNewIntroductionCell class])];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.block = ^(NSString *string){
                NSLog(@"--------------------%@",string);
                self.model.inString = string;
            };
            return cell;
        }
            break;
        case 2:
        {
            ProductAddNewPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductAddNewPriceCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.block = ^(NSString *string){
                NSLog(@"--------------------%@",string);
                char c = [string characterAtIndex:0];
                self.model.priceString = string;
                if (c <= '9' && c>='0') {
                    
                }else{
                    MBProgressHUD* mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    mbp.mode = MBProgressHUDModeText;
                    mbp.labelText = @"价格输入错误";
                    [mbp hide:YES afterDelay:1];
                }
            };
            return cell;
        }
            break;
            case 3:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
            cell.showCustomLine = YES;
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.textLabel.text = @"上传产品主图片";
            return cell;
        }
            break;
            case 4:
        {
            ProductImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductImageCell class])];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            __weak ProductImageCell *myCell = cell;
            cell.block = ^(UIButton *button){
                [ZZImagePickerManager pickImageInController:self completionHandler:^(UIImage *image) {
                    [self.view endEditing:YES];
                    self.model.productImage = image;
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:button.frame];
                    imageView.image = image;
                    // CGSize size = CGSizeMake(ceil(imageView.frame.size.width), ceil(imageView.frame.size.height));
//                    self.addModel.license = [Base64 stringByEncodingData:UIImageJPEGRepresentation([CustomImage compressImage:image maxSize:1024 * 1000], 1.0)];
                    [myCell addSubview:imageView];
                    [button removeFromSuperview];
                }];
            };
            return cell;
        }
            break;
        case 5:
        {
            ProductInventoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductInventoryCell class])];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.block = ^(NSString *numberString,NSString *unitString){
                NSLog(@"----------numberString:%@%@",numberString,unitString);
                self.model.numberString = numberString;
                self.model.unitString = unitString;
            };
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
