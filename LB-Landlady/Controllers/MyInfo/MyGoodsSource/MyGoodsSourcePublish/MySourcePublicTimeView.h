//
//  MySourcePublicTimeView.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/18/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySourcePublicTimeModel : NSObject

@property (nonatomic, copy) NSString *typeInfo;
@property (nonatomic) NSInteger type;

- (instancetype)initWithType:(NSInteger)type info:(NSString *)info;
@end

@interface MySourcePublicTimeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, copy) dispatch_block_t callbackHandler;

@property (nonatomic) MySourcePublicTimeModel *model;

@end
