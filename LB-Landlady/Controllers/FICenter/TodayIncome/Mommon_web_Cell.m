//
//  Mommon_web_Cell.m
//  MeZoneB_Bate
//
//  Created by ios on 15/11/20.
//  Copyright (c) 2015年 Lianbi. All rights reserved.
//

#import "Mommon_web_Cell.h"
#import "JsonStringHelper.h"

@implementation Mommon_web_Cell

- (void)awakeFromNib {
}
-(void)setTip:(int)tip
{
    
    _tip = tip;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.tip!=0) {
            [self initWebView];
        }
        
    });
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSString *)setRequestHeaderStr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_type forKey:@"type"];
    [dic setObject:@"#262626" forKey:@"titleColor"];
    [dic setObject:[NSNumber numberWithFloat:self.contentView.frame.size.width] forKey:@"width"];
    [dic  setObject:[NSNumber numberWithFloat:300.0] forKey:@"height"];
    

    if ([self.type isEqualToString:@"line"]) {
        [dic setObject:_xName forKey:@"xName"];
        [dic setObject:_yName forKey:@"yName"];
        [dic setObject:@"#ff7e00" forKey:@"color"];
        NSMutableDictionary *templeDic = [NSMutableDictionary dictionary];
        
        [templeDic setObject:_yArray forKey:@"data"];
        [dic setObject:@[templeDic] forKey:@"yData"];
        [dic setObject:_xData forKey:@"xData"];
    
    }else
    {
        [dic setObject:@70 forKey:@"outerRadius"];
        [dic setObject:@50 forKey:@"innerRadius"];
        [dic setObject:_yArray forKey:@"yData"];
        
    }

    return [JsonStringHelper dictionaryToJson:dic];
}
- (void)initWebView
{
    self.webView.scrollView.scrollEnabled = NO;
    if ([self.type isEqualToString:@"line"]) {
        self.backView.alpha = 0;
        if (_yArray&&_xData) {
            NSString *jsonString = [self setRequestHeaderStr];
            NSString *urlStr = [NSString stringWithFormat:@"%@?param=%@",[URLService pictureForIncomeUrl],jsonString];
            FMLog(@"%@",urlStr);
            //iOS 8
            urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            //iOS 9
//                urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
            [self.webView loadRequest:request];
        }
    }else
    {
        self.heightConstraint.constant = 240;
        
        if (_yArray) {
            NSString *jsonString = [self setRequestHeaderStr];
            NSString *urlStr = [NSString stringWithFormat:@"%@?param=%@",[URLService pictureForIncomeUrl],jsonString];
            FMLog(@"  pie %@",urlStr);
            //iOS 8
            urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
            [self.webView loadRequest:request];
        }   
    }
}

#pragma mark ************************ WebView Delegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"failed");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finished");
}

@end
