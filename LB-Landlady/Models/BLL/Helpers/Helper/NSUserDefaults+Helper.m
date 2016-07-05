//
//  NSUserDefaults+Helper.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/23/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "NSUserDefaults+Helper.h"

@implementation NSUserDefaults (Helper)

- (void)setLatitude:(NSString *)latitude {
    [self setValue:latitude forKey:@"latitude"];
}

- (void)setLongitude:(NSString *)longitude {
    [self setValue:longitude forKey:@"longitude"];
}

- (NSString *)latitude {
    return [self stringForKey:@"latitude"];
}

- (NSString *)longitude {
    return [self stringForKey:@"longitude"];
}

- (void)setUsername:(NSString *)username {
    [self setValue:username forKey:@"username"];
}

- (NSString *)username {
    return [self stringForKey:@"username"];
}

- (void)setPassword:(NSString *)password {
    [self setValue:password forKey:@"password"];
}

- (NSString *)password {
    return [self stringForKey:@"password"];
}

- (BOOL)didAccess {
    return [self boolForKey:@"didAccess"];
}

- (void)setDidAccess:(BOOL)didAccess {
    [self setBool:didAccess forKey:@"didAccess"];
}

- (void)clear {
    [self removeObjectForKey:@"latitude"];
    [self removeObjectForKey:@"longitude"];
    [self removeObjectForKey:@"username"];
    [self removeObjectForKey:@"password"];
}
@end
