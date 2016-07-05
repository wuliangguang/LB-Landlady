//
//  NSObject+Helper.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/7/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

@implementation NSObject (Helper)

- (void)setAttachObject:(id)attachObject {
    objc_setAssociatedObject(self, "attachObject", attachObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)attachObject {
    return objc_getAssociatedObject(self, "attachObject");
}

@end
