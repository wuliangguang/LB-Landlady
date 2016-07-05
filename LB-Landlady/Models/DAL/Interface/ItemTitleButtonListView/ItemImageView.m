//
//  ItemImageView.m
//  LB-Landlady
//
//  Created by 刘威振 on 1/13/16.
//  Copyright © 2016 Lianbi.com.cn. All rights reserved.
//

#import "ItemImageView.h"

@implementation ItemImageView

- (CGSize)intrinsicContentSize {
    CGSize size = self.image.size;
    if (size.width > self.bounds.size.width || size.height > self.bounds.size.height) {
        return self.bounds.size;
    }
    return size;
}

@end
