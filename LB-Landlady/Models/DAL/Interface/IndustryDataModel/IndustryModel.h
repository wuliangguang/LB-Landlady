//
//  IndustryModel.h
//  LB-Landlady
//
//  Created by 刘威振 on 1/26/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndustryModel : NSObject

@property (nonatomic, copy) NSString *industryId;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *industryName;
@property (nonatomic, getter=isCheck) BOOL check;
@end
