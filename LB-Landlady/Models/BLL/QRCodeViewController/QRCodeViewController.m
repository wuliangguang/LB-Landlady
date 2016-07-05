//
//  QRCodeViewController.m
//  MeZoneB
//
//  Created by 阳有元 on 15/2/4.
//  Copyright (c) 2015年 d2space. All rights reserved.
//

#import "QRCodeViewController.h"
#import "CustomImage.h"
#import "MBProgressHUD+ZZConvenience.h"
#import "NotificationHelper.h"
#import "NSObject+Helper.h"

@interface QRCodeViewController () <UIAlertViewDelegate>

@property (nonatomic , strong) UITextField * textFeild;
@property (nonatomic) NSInteger repeatCount;
@end

@implementation QRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"扫一扫";
    [self initZbar];
    [self initInputQrcodeTextField];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_readerView stop];
    [_readerView removeFromSuperview];
    [_readerView flushCache];
}
- (void)initInputQrcodeTextField
{
    self.textFeild = [[UITextField alloc]initWithFrame:CGRectMake(0, (kScreenHeight - 136), kScreenWidth, 45)];
    self.textFeild.placeholder = @"也可以手动输入二维码喔！";
    self.textFeild.textAlignment = NSTextAlignmentCenter;
    self.textFeild.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textFeild];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(0, (kScreenHeight - 89), kScreenWidth, 45);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor whiteColor];
    [confirmBtn setTitleColor:[UIColor colorWithRed:0.078 green:0.46 blue:1 alpha:1] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmQrcode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
}
- (void)confirmQrcode:(UIButton *)btn
{
    if (self.textFeild.text.length > 0)
    {
        [self postQrcode:self.textFeild.text];
    }
}


-(void)backButton:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)initZbar
{
    _readerView = [[ZBarReaderView alloc]init];
    _readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _readerView.readerDelegate = self;
    //关闭闪光灯
    _readerView.torchMode = 0;
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR)
    {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = _readerView;
    }
    [self.view addSubview:_readerView];
    
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:_readerView.bounds];
    image.image = [UIImage imageNamed:@"Phicommimeikuang"];
    [_readerView addSubview:image];
    //扫描选中的框是否显示
    _readerView.tracksSymbols = NO;

    [self initScanBoundle:_readerView];
    [_readerView start];
    [self startScan];
    
}

- (void)initScanBoundle:(ZBarReaderView*)reader
{
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,250, 2)];
    _line.image = [CustomImage imageWithColor:[UIColor grayColor] size:CGSizeMake(250, 2)];
    if (iPhone6P)
    {
        _line.frame = CGRectMake(0, 0, 250, 2);
    }
    else if (iPhone6)
    {
        _line.frame = CGRectMake(0, 0, 220, 2);
    }
    else
    {
        _line.frame = CGRectMake(0, 0, 200, 2);
    }
    self.scanBoundle = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width -250)/2, 126, 250, 155)];
    [self.scanBoundle addSubview:_line];
    [reader addSubview:self.scanBoundle];
}

#pragma mark - CustomerMethod
- (void)startScan
{
    [_readerView start];
    _timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(locationAnimation) userInfo:nil repeats:YES];
}

-(void)locationAnimation
{
    if (iPhone6P)
    {
        if (_line.frame.origin.y > 300.0)
        {
            _line.frame = CGRectMake(0, 20, 250, 2);
        }
        else if (_line.frame.origin.y > 0)
        {
            _line.frame = CGRectMake(0, _line.frame.origin.y + 5, 250, 2);
        }
        else
        {
            _line.frame = CGRectMake(0, _line.frame.origin.y + 5, 250, 2);
        }
    }
    else if (iPhone6)
    {
        if (_line.frame.origin.y > 250.0)
        {
            _line.frame = CGRectMake(15, 20, 220, 2);
        }
        else if (_line.frame.origin.y > 0)
        {
            _line.frame = CGRectMake(15, _line.frame.origin.y + 5, 220, 2);
        }
        else
        {
            _line.frame = CGRectMake(15, _line.frame.origin.y + 5, 220, 2);
        }
    }
    else
    {
        if (_line.frame.origin.y > 200.0)
        {
            _line.frame = CGRectMake(25, 0, 200, 2);
        }
        else if (_line.frame.origin.y > 0)
        {
            _line.frame = CGRectMake(25, _line.frame.origin.y + 5, 200, 2);
        }
        else
        {
            _line.frame = CGRectMake(25, _line.frame.origin.y + 5, 200, 2);
        }
    }
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    return CGRectMake(x, y, width, height);
}


- (void)postQrcode:(NSString *)qrcode
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString * urlStr = [URLService getSweepPushCardUrl];
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setObject:self.price forKey:@"amount"];
        [params setObject:qrcode forKey:@"sweepStr"];
        [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
         [params setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
        [params setObject:self.orderId forKey:@"orderId"];
        [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
            if ([responseObject[@"code"] integerValue] == SUCCESS_CODE)
            {
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [self delayMethod:self.orderId];
                });
            }
        } failure:^(NSError *error) {
            
        } WithController:self];
    });
}
-(void)delayMethod:(NSString * )orderId
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ZBarDelegate

- (void) readerViewDidStart: (ZBarReaderView*) readerView
{
    
}

- (void) readerView: (ZBarReaderView*) view didReadSymbols: (ZBarSymbolSet*) syms fromImage: (UIImage*) img
{
    for(ZBarSymbol *symbol in syms)
    {
        NSLog(@"%@",symbol.data);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSString * urlStr = [URLService getSweepPushCardUrl];
            NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
            [params setObject:self.price forKey:@"amount"];
            [params setObject:symbol.data forKey:@"sweepStr"];
            [params setObject:App_User_Info.myInfo.userModel.userId forKey:@"userId"];
            [params setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
            [params setObject:self.orderId forKey:@"orderId"];
            [S_R LB_GetWithURLString:urlStr WithParams:params WithSuccess:^(id responseObject, id responseString) {
                if ([responseObject[@"code"] integerValue] == SUCCESS_CODE)
                {
                    NSLog(@"%@", responseString);
                    NSString *orderId = responseObject[@"data"][@"isTrue"];
                    [self checkOrder:orderId];
                }
            } failure:^(NSError *error) {
                
            } WithController:self];
        });
    }
    
    [_timer invalidate];
    [_readerView stop];
}

- (void)dismiss:(BOOL)success {
    if (success) {
        [NotificationHelper postNotificationOfIncomeChangeWithObject:self userInfo:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 查询订单状态
 * @param orderId 订单号
 * @param repeatCount 调用次数
 */
- (void)checkOrder:(NSString *)orderId {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请确认客户已支付" message:nil delegate:self cancelButtonTitle:@"查看支付结果" otherButtonTitles:nil, nil];
    alertView.attachObject = orderId;
    [alertView show];
    
#if 0
    /**
     * 订单号 -> 查询订单是否成功
     * 成功：pop
     * 失败：1. 等15秒（正在查询支付结果） 2. 15秒请求查询订单是否成功（成功/失败pop掉）
     */
    ++self.repeatCount;
    [S_R LB_GetWithURLString:[URLService orderQuery] WithParams:@{@"orderId" : orderId, @"isLast" : self.repeatCount < 4 ? @"0" : @"1"} WithSuccess:^(id responseObject, id responseString) {
        NSLog(@"%@", responseString);
        BOOL success = [responseObject[@"data"][@"isTrue"] boolValue];
        if (success) { // 如果成功
            [MBProgressHUD showSuccessToast:@"支付成功" inView:self.view completionHandler:^{
                [self dismiss:YES];
            }];
        } else {
            if (self.repeatCount > 4) {
                [MBProgressHUD showFailToast:@"支付失败，请客户不要再支付" inView:self.view completionHandler:nil];
                [self dismiss:NO];
                return ;
            }
            [MBProgressHUD showToast:@"正在查询订单状态" inView:self.view.window timeInterval:5.0 completionHandler:^{
                [self checkOrder:orderId];
            }];
            
            /**
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:self.view.window];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"正在查询支付结果";
            [hud hide:YES afterDelay:15.0];
             */
        }
    } failure:^(NSError *error) {
        /**
        [MBProgressHUD showToast:@"正在查询支付结果" inView:self.view.window timeInterval:5.0 completionHandler:^{
            [self checkOrder:orderId];
        }];
         */
        [self dismiss:NO];
    } WithController:self];
#endif
}

#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.attachObject) {
        NSString *orderId = (NSString *)alertView.attachObject;
        [S_R LB_GetWithURLString:[URLService orderQuery] WithParams:@{@"orderId" : orderId, @"isLast" :  @"1"}  WithSuccess:^(id responseObject, id responseString) {
            // NSLog(@"%@", responseString);
            BOOL success = [responseObject[@"data"][@"isTrue"] boolValue];
            if (success) {
                [MBProgressHUD showSuccessToast:@"支付成功" inView:self.view.window completionHandler:^{
                    [self dismiss:YES];
                }];
            } else {
                [MBProgressHUD showFailToast:@"支付失败，请客户不要再支付" inView:self.view completionHandler:^{
                    [self dismiss:NO];
                }];
            }
        } failure:^(NSError *error) {
            [self dismiss:NO];
        } WithController:self];
    } else {
        [self startScan];
    }
}

#pragma mark ************************* AlertView TextalignmentLeft *************************
- (void)textAlignmentLeft:(NSString *)message InAlertView:(UIAlertView *)alert
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, -20, 240, 0)];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = [UIColor blackColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.text =[NSString stringWithFormat:@"%@",message];;
    
    CGSize requiredSize = CGSizeZero;
    if (IOS6)
    {
        requiredSize = [message sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(240, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail];
    }
    else
    {
        CGSize size = CGSizeMake(textLabel.frame.size.width, CGFLOAT_MAX);
        NSDictionary *attribute = @{NSFontAttributeName:textLabel.font};
        requiredSize = [textLabel.text boundingRectWithSize:size options:\
                        NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    textLabel.frame = CGRectMake(10, -20, 240, requiredSize.height);
    
    [alert setValue:textLabel forKey:@"accessoryView"];
    alert.message = @"";
}
@end
