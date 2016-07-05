//
//  ServerMallListDataModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/21/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateTimeModel.h"
#import "ServermalllistModel.h"

@interface ServerMallListDataModel : NSObject

@property (nonatomic) NSArray<ServermalllistModel *> *serverMallList;
@end
