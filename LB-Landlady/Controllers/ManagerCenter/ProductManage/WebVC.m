//
//  WebVC.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/18.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "WebVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JsonStringHelper.h"
#import "ZZImagePickerManager.h"

@interface WebVC ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIImage *selectedImage;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.urlString.length > 0)
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ButtonClick------
- (IBAction)addBtnClick:(UIButton *)sender {
    [ZZImagePickerManager pickImageInController:self completionHandler:^(UIImage *image) {
        [sender setImage:image forState:UIControlStateNormal];
        self.selectedImage = image;
//        [self.selectImageBtn setImage:image forState:UIControlStateNormal];
//        self.selectedImageView.image = image;
    }];
}
#pragma mark WebView Method
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"getData"] = ^(NSString *param)
    {
        
        NSDictionary *params = [JsonStringHelper dictionaryWithJsonString:param];
        FMLog(@"%@",params);
        /**
         *  params[@"status"] == NO 异常，吐司内容 params[@"msg"]
         */
        if ([params[@"status"] boolValue] == NO)
        {
            NSLog(@"%@",params[@"msg"]);
            dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = params[@"msg"];
                [hud hide:YES afterDelay:ERROR_DELAY];
            });
        }
        else
        {
            //该干嘛，干嘛
            [self addProductInfo:params];
            
        }
    };
}


#pragma mark ------NetRequest-------
/**
	*   	@param  imageList		string    图片多个以英文','逗号拼接
	*    	@param  type			string    产品类型
	*    	@param  serviceType		string    服务类型
	*       @param  startTime		string    开始时间
	*       @param  endTime			string    结束时间
	*       @param  isPay			string    是否需要预支付
	*       @param  productName		string    服务名称
	*       @param  detail			string    服务详细
    *       @param  price 			string  
    *       @param  unit 			string
    *       @param  businessId 	    string
    *
 */
-(void)addProductInfo:(NSDictionary *)params
{
    if (self.selectedImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSString * urlStr = [URLService addProductInfo];
            NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithDictionary:params];
            NSData *imageData = UIImageJPEGRepresentation(self.selectedImage, 0.01);
            NSString * imageStr = [Base64 stringByEncodingData:imageData];
            [param setObject:imageStr  forKey:@"imageList"];
            [param setObject:App_User_Info.myInfo.userModel.defaultBusiness forKey:@"businessId"];
            [S_R LB_PostWithURLString:urlStr WithParams:param WithSuccess:^(id responseObject, id responseString) {
                FMLog(@"get ->responseObject = %@/n %@",responseObject,responseString);
                if ([responseObject[@"code"] integerValue] == SUCCESS_CODE) {
                    if (self.addBlock) {
                        self.addBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                FMLog(@"error = %@",error.userInfo);
            } WithController:self];
        });
    }else
    {
       dispatch_async(dispatch_get_main_queue(), ^{
           MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
           hud.mode = MBProgressHUDModeText;
           hud.labelText = @"请上传产品图片";
           [hud hide:YES afterDelay:ERROR_DELAY];

       });
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
