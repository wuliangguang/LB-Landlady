//
//  CommonModel.h
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  CommonModel作为整个App的Model，不同点在于data字段
 */
@interface CommonModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic) id data;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic,copy)NSString *totalAmt;
/**
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @cls 即data所对应的类，如果传为nil, 则不对data进行解析
 *  @return 新建的CommonModel对象
 */
+ (instancetype)commonModelWithKeyValues:(id)keyValues dataClass:(Class)cls;

+ (instancetype)commonModelWithKeyValues:(id)keyValues;

@end

@interface NSObject (dataModel)

/**
 *  此接口慎用
 *
 *  @param keyValues 原始的keyValue
 *
 *  @return 返回的总数据的data字段解析后的对象
 */
+ (instancetype)dataObject:(id)keyValues;
@end

