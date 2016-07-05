//
//  CommonModel.m
//  LB-Landlady
//
//  Created by 露露 on 16/1/20.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

+ (instancetype)commonModelWithKeyValues:(id)keyValues dataClass:(Class)cls {
    //keyValues是字典
    CommonModel *model = [CommonModel mj_objectWithKeyValues:keyValues];
    if (model.data && cls) {
        model.data = [cls mj_objectWithKeyValues:model.data];
    }
    return model;
}

+ (instancetype)commonModelWithKeyValues:(id)keyValues {
    return [self commonModelWithKeyValues:keyValues dataClass:nil];
}

@end

@implementation NSObject (dataModel)

+ (instancetype)dataObject:(id)keyValues {
    CommonModel *commonModel = [CommonModel commonModelWithKeyValues:keyValues dataClass:[self class]];
    return commonModel.data;
}
@end
