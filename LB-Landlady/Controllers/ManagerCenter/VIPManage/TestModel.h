//
//  TestModel.h
//  SwitchPage
//
//  Created by d2space on 16/1/12.
//  Copyright © 2016年 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property (nonatomic, strong) NSString *name;

/** 未读/已读 */
@property (nonatomic, getter=isRead) BOOL read;

/** 选中/未选中 */
@property (nonatomic, getter=isCheck) BOOL check;

/** 编辑/非编辑 */
@property (nonatomic, getter=isEditing) BOOL editing;

@end
