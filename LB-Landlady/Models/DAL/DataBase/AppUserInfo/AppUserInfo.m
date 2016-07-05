//
//  AppUserInfo.m
//  MeZoneB
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import "AppUserInfo.h"

@implementation AppUserInfo

static AppUserInfo *sharedAccountManagerInstance = nil;

+ (instancetype)initAppUserInfo {
    @synchronized(self) {
        if (sharedAccountManagerInstance == nil) {
            sharedAccountManagerInstance = [[AppUserInfo alloc] init];
        }
        return sharedAccountManagerInstance;
    }
    
    /*
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
     */
}

- (void)clearCache {
    sharedAccountManagerInstance = nil;
}

@end






