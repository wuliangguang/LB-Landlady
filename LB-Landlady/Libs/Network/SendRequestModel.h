//
//  SendRequestModel.h
//  LB-Landlady
//
//  Created by 张伯林 on 16/4/28.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendRequestModel : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic)NSString *detailStr;

+(NSString *)backStrFromeArr:(NSArray *)arr;
@end
