//
//  QRCodeViewController.h
//  MeZoneB
//
//  Created by 阳有元 on 15/2/4.
//  Copyright (c) 2015年 d2space. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import <AVFoundation/AVFoundation.h>


@interface QRCodeViewController : UIViewController<ZBarReaderViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIImageView *line;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *scanBoundle;

@property (nonatomic, strong) ZBarReaderView *readerView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign)BOOL           isFromFirstPageRightCorner;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *orderId;

@end
