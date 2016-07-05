//
//  NSObject+Helper.h
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/7/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)

/**
 *  OC运行时动态绑定Dynamic binding，需要key: objc_setAssociatedObject(id obj, key, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
 *  为了统一起见
 *
 *  @return key
 */

@property (nonatomic) id attachObject; // getter, setter

@end
