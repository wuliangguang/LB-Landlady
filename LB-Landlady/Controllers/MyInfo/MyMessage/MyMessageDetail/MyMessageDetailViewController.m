//
//  MyMessageDetailViewController.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "MyMessageDetailViewController.h"
#import "UIViewController+ZZNavigationItem.h"
#import "CommonModel.h"

@interface MyMessageDetailViewController ()

/**
 *  消息类型
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 *  内容详情
 */
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation MyMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"我的消息";
    self.typeLabel.layer.cornerRadius = self.typeLabel.frame.size.height/2.0f;
    [self.typeLabel setClipsToBounds:YES];
    
    UIButton *button = [self addStandardRightButtonWithTitle:@"删除" selector:@selector(delete)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.typeLabel.text       = self.messageModel.messageTypeStr;
    self.titleLabel.text      = self.messageModel.message_title;
    self.timeLabel.text       = self.messageModel.messageCreateTime;
    self.contentTextView.text = self.messageModel.message_content;
}

- (void)delete {
    NSDictionary *dict = @{@"messageId" : self.messageModel.message_id};
    [S_R LB_GetWithURLString:[URLService getDelMessageUrl] WithParams:dict WithSuccess:^(id responseObject, id responseString) {
        CommonModel *commonModel = [CommonModel commonModelWithKeyValues:responseObject];
        if (commonModel.code == SUCCESS_CODE) {
            NSLog(@"%@", responseString);
            if (self.callbackHandler) {
                self.callbackHandler(self);
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    } WithController:self];
}

@end
