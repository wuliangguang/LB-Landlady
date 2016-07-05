//
//  CallWaiterTableVC.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/13.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "ChangeInfoTableVC.h"
#import "WaiterManagerViewController.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "WaiterManagerViewController.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Base64.h"

@interface ChangeInfoTableVC ()
@property(nonatomic,strong)MBProgressHUD * Mbp;
@property (nonatomic) UIImage *image;


@end

@implementation ChangeInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_model == nil) {
        self.title = @"新增店员";
        _photoLab.text = @"头像上传";
        _headerIMGView.image = [UIImage imageNamed:@"defultheadimage"];
    } else {
        if ([_model.salesclerk_image isEqualToString:@""]) {
            _headerIMGView.image = [UIImage imageNamed:@"defultheadimage.png"];
        }else
        {
            [_headerIMGView sd_setImageWithURL:[NSURL URLWithString:_model.salesclerk_image] placeholderImage:nil];
        }
    }
    _numTF.text = [NSString stringWithFormat:@"%ld",(long)_model.salesclerk_id];
    _nameTF.text = _model.salesclerk_name;
    [_nameTF setValue:@6 forKey:@"limit"];
    _phoneTF.text = _model.salesclerk_phone;
    [_phoneTF setValue:@11 forKey:@"limit"];
    _positionTF.text = _model.salesclerk_job;
    [self initSaveButton];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    _headerIMGView.layer.cornerRadius = 20;
    _headerIMGView.clipsToBounds = YES;
}
#pragma mark ----- init初始化 -----
-(void)initSaveButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 300, kScreenWidth-40, 40);
    [button setBackgroundColor:[HEXColor getColor:@"#ff3c25"]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark --------btnClick-------
-(void)saveBtnClick:(UIButton * )btn
{
    NSString * mes = nil;
    if ([self.headerIMGView.image isEqual:[UIImage imageNamed:@"defultheadimage"]]) {
        mes = @"请上传店员头像";
    }else
    if ([self.nameTF.text isBlank])
    {
        mes = @"请输入员工姓名";
    }else if ([self.phoneTF.text isBlank])
    {
        mes = @"请输入员工手机号";
    }else if (![self.phoneTF.text isVAlidPhoneNumber])
    {
        mes = @"请输入正确的手机号";
    }
    else if ([self.positionTF.text isBlank]) 
    {
        mes = @"请输入员工职位";
    }
    if (mes) {
        _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _Mbp.mode = MBProgressHUDModeText;
        _Mbp.labelText = mes;
        [_Mbp hide:YES afterDelay:2];
    }else
    {
        if ([self.title isEqualToString:@"新增店员"]) {
            [self addWaiter];
        }else
        {
            [self changeInfo];
        }
    }
}

#pragma mark ------NetRequest-------

// 新增店员
-(void)addWaiter
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getAddSalesclerkUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:self.nameTF.text forKey:@"alesclerkName"];
        [params setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
        [params setObject:self.phoneTF.text forKey:@"alesclerkPhone"];
        if (self.positionTF.text.length != 0) {
            [params setObject:self.positionTF.text forKey:@"alesclerkJob"];
        }
        NSString * imageStr = self.headerIMGView.image.base64Str;
        [params setObject:imageStr forKey:@"salesclerkImg"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            FMLog(@"responseObject:%@------responseString:%@",responseObject,responseString)
             NSString * mes = nil;
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                    mes = @"添加成功";
                    if (self.callbackHandler) {
                        self.callbackHandler(nil);
                    }
                    
                    [self popToWaiterList];
            } else {
                mes = @"添加失败";
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                _Mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _Mbp.mode = MBProgressHUDModeText;
                _Mbp.labelText = mes;
                [_Mbp hide:YES afterDelay:2];
                [self.tableView reloadData];
                
                if (self.callbackHandler) {
                    
                }
            });
        } failure:^(NSError *error) {
            FMLog(@"error --- %@",error);
        } WithController:self];
    });
}
// 修改姓名等 -> 修改头像 注意这是两个接口，修改头像单独作为一个接口
-(void)changeInfo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * pathStr = [URLService getUpateSalesclerkUrl];
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        // *  @param  	alesclerkId		int			员工ID
//        * 	@param		alesclerkName	string		员工姓名
//        * 	@param		alesclerkBank	string		员工卡号
//        * 	@param		businessId		string		门店ID
//        * 	@param		alesclerkSex	int			员工性别
//        * 	@param		alesclerkAddress	string	地址
//        * 	@param		alesclerkDetail		string	描述
        [params setObject:[NSNumber numberWithInt:_model.salesclerk_id] forKey:@"alesclerkId"];
        [params setObject:self.nameTF.text forKey:@"alesclerkName"];
        [params setObject:self.phoneTF.text forKey:@"alesclerkPhone"];
        [params setObject:self.positionTF.text forKey:@"alesclerkJob"];
        [params setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
        NSData * imageData = UIImageJPEGRepresentation(self.headerIMGView.image, 0.5);
        NSString * imageStr = [Base64 stringByEncodingData:imageData];
        [params setObject:imageStr forKey:@"salesclerkImg"];
        [S_R LB_GetWithURLString:pathStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            NSString * mes = nil;
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                    // 修改成功
                if (self.callbackHandler) {
                    _model.salesclerk_name     = self.nameTF.text;
                    _model.salesclerk_job = self.positionTF.text;
                    _model.salesclerk_phone    = self.phoneTF.text;
                    self.callbackHandler(_model);
                }
                [MBProgressHUD showToast:@"修改成功" inView:self.view timeInterval:1 completionHandler:^{
                    [self popToWaiterList];
                }];
            }
            else {
                mes = @"修改失败";
         }
         dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        } failure:^(NSError *error) {
        } WithController:self];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.title isEqualToString:@"新增店员"]) {
        if (section == 1) {
            return 0.01;
        }
    }
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.title isEqualToString:@"新增店员"]) {
        if (indexPath.section == 1) {
            _section1Cell.alpha = 0 ;
            _waiterNumLab.alpha = 0;
            return 0;
        }
    }
    if (indexPath.section == 0) {
        return 60;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self OpenActionSheetView];
        }
            break;
        case 1:
            [_numTF becomeFirstResponder];
            break;
        case 2:
        {
            UITextField * field = (UITextField *)[self.tableView viewWithTag:1001+indexPath.row];
            [field becomeFirstResponder];
      
        }
            break;
            
        default:
            break;
    }
}

-(void)OpenActionSheetView
{
    [self.view endEditing:YES];

    UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
    //    [sheet showInView:self.view];
}


#pragma mark - ActionSheet
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //相册
        [self openPhotosLibrary];
    }
    else if (buttonIndex == 1)
    {
        //拍照
        [self takePhotos];
    }
//    else
//    {
//        if (App_User_Info.IsNaviTitle == YES)
//        {
//            [self.navigationController popViewControllerAnimated:YES];
//            App_User_Info.IsNaviTitle = NO;
//        }
//    }
    
}

-(void)popToWaiterList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id item in self.navigationController.viewControllers)
        {
            if ([item isKindOfClass:[WaiterManagerViewController class]])
            {
                WaiterManagerViewController *vc = (WaiterManagerViewController*)item;
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    });
}

#pragma mark - 从本地获取图片
//打开相册
-(void) openPhotosLibrary
{
    self.imagePicker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        //指定几总图片来源
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"Error accessing photo library!"
                                                      delegate:nil
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

//拍照
- (void) takePhotos
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        //self.imagePicker = nil;
        UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        CGSize size = CGSizeMake(ceil(self.headerIMGView.frame.size.width), ceil(self.headerIMGView.frame.size.height));
        editedImage = [self smallImage:editedImage size:size];
        self.headerIMGView.image = editedImage;
        if (editedImage) {
            self.image = editedImage; // 用户选择的准备上传的新头像
        }
    }];
}


- (UIImage *)smallImage:(UIImage *)original size:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width,
                                                 size.height,
                                                 8,
                                                 size.width * 8,
                                                 colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context,
                       CGRectMake(0, 0, size.width, size.height),
                       original.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return final;
    
}


@end
